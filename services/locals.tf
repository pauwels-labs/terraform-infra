locals {
  collapse_envs            = length(var.tenant_collapse_envs_to) > 0 ? true : false
  tenant_repo_host_name    = replace(var.tenant_repo_domain, "/([^\\.]+)\\.([^\\.]+)$/", "$1")
  env_to_service_map       = {
    for env in var.tenant_envs : env.name => [
      for service in var.services : service.envs == null ? service : (contains(service.envs.*.name, env.name) ? service : null)
    ]
  }
  env_to_resources_map     = {
    for env, services in local.env_to_service_map : env => distinct([for service in services : "${service.name}${local.collapse_envs ? "-${env}" : ""}.yaml" if service != null])
  }
  env_to_kustomization_map = {
    for env, resources in local.env_to_resources_map : env => {
      "apiVersion" = "kustomize.config.k8s.io/v1beta1"
      "kind"       = "Kustomization"
      "namespace"  = "t-${var.tenant_name}"
      "resources"  = local.collapse_envs ? (
        var.tenant_collapse_envs_to == env ? concat(
          ["../base"],
          flatten([for env, resources in local.env_to_resources_map : resources])) : ["../base"]
        ) : concat(["../base"], resources)
    }
  }
  kustomization_infra_yaml = {
    "apiVersion" = "kustomize.config.k8s.io/v1beta1"
    "kind"       = "Kustomization"
    "namespace"  = "t-${var.tenant_name}"
    "resources"  = concat(
      ["../base", "configmap-lighthouse-config.yaml", "configmap-lighthouse-plugins.yaml"],
      [for service in var.services : "externalsecret-ssh-${var.tenant_name}-${local.tenant_repo_host_name}-${var.tenant_repo_org_name}-${service.name}.yaml"]
      )
  }
  configmap_lighthouse_config_yaml = {
    "apiVersion"        = "v1"
    "kind"              = "ConfigMap"
    "metadata"          = {
      "name"   = "config"
      "labels" = {
        "toolkit.fluxcd.io/tenant" = var.tenant_name
      }
    }
    "data"              = {
      "config.yaml" = yamlencode(local.lighthouse_config_yaml)
    }
  }
  lighthouse_config_yaml = {
    "pod_namespace"     = "t-${var.tenant_name}"
    "prowjob_namespace" = "t-${var.tenant_name}"
    "postsubmits"       = {
      for service in var.services : "${var.tenant_repo_org_name}/${service.name}" => [
        {
          "agent"     = "tekton-pipeline"
          "branches"  = [
            "main"
          ]
          "context"   = "release"
          "name"      = "release"
          "clone_uri" = "git@github.com:${var.tenant_repo_org_name}/${service.name}.git"
          "pipeline_run_spec"   = yamldecode(file("${path.module}/pipelinerunspec_release.yaml"))
          "pipeline_run_params" = [
            {
              "name"           = "tenantName"
              "value_template" = "${var.tenant_name}"
            },
            {
              "name"           = "imageRegistry"
              "value_template" = "274295908850.dkr.ecr.eu-west-1.amazonaws.com"
            },
            {
              "name"           = "ghTokenSecretName"
              "value_template" = "token-github-capt-haddock"
            }
          ]
        }
      ]
    }
    "presubmits"        = {
      for service in var.services : "${var.tenant_repo_org_name}/${service.name}" => [
        {
          "agent"               = "tekton-pipeline"
          "context"             = "unit"
          "name"                = "unit"
          "clone_uri"           = "git@github.com:${var.tenant_repo_org_name}/${service.name}.git"
          "always_run"          = true
          "optional"            = false
          "pipeline_run_spec"   = yamldecode(file("${path.module}/pipelinerunspec_testunit.yaml"))
          "pipeline_run_params" = [
            {
              "name"           = "tenantName"
              "value_template" = "${var.tenant_name}"
            },
            {
              "name"           = "imageRegistry"
              "value_template" = "274295908850.dkr.ecr.eu-west-1.amazonaws.com"
            },
            {
              "name"           = "ghTokenSecretName"
              "value_template" = "token-github-capt-haddock"
            }
          ]
        },
        {
          "agent"               = "tekton-pipeline"
          "context"             = "build"
          "name"                = "build"
          "clone_uri"           = "git@github.com:${var.tenant_repo_org_name}/${service.name}.git"
          "always_run"          = true
          "optional"            = false
          "pipeline_run_spec"   = yamldecode(file("${path.module}/pipelinerunspec_testbuild.yaml"))
          "pipeline_run_params" = [
            {
              "name"           = "tenantName"
              "value_template" = "${var.tenant_name}"
            },
            {
              "name"           = "imageRegistry"
              "value_template" = "274295908850.dkr.ecr.eu-west-1.amazonaws.com"
            }
          ]
        }
      ]
    }
    "in_repo_config"    = {
      "enabled" = {
        "*" = true
      }
    }
    "tide"              = {
      "queries" = [
        {
          "labels"        = [
            "approved"
          ]
          "missingLabels" = [
            "do-not-merge",
            "do-not-merge/hold",
            "do-not-merge/work-in-progress",
            "needs-ok-to-test"
          ]
          "repos"         = [
            for service in var.services : "${var.tenant_repo_org_name}/${service.name}"
          ]
        }
      ]
    }
  }

  configmap_lighthouse_plugins_yaml = {
    "apiVersion"        = "v1"
    "kind"              = "ConfigMap"
    "metadata"          = {
      "name"   = "plugins"
      "labels" = {
        "toolkit.fluxcd.io/tenant" = var.tenant_name
      }
    }
    "data"              = {
      "plugins.yaml" = yamlencode(local.lighthouse_plugins_yaml)
    }
  }
  lighthouse_plugins_yaml = {
    "approve"        = [
      {
        "lgtm_acts_as_approve"  = false
        "repos"                 = concat(
          ["${var.tenant_repo_org_name}/tenant-${var.tenant_name}"],
          [for service in var.services : "${var.tenant_repo_org_name}/${service.name}"]
          )
        "require_self_approval" = true
      }
    ]
    "config_updater" = {
      "gzip" = false
      "maps" = {
        "infra/configmap-lighthouse-config.yaml"  = {
          "name" = "config"
        }
        "infra/configmap-lighthouse-plugins.yaml" = {
          "name" = "plugins"
        }
      }
    }
    "triggers"       = [
      {
        "repos"                  = [
          for service in var.services : "${var.tenant_repo_org_name}/${service.name}"
        ]
        "ignore_ok_to_test"      = false
        "elide_skipped_contexts" = false
      }
    ]
    "plugins"        = merge(
      {
        "pauwels-labs/tenant-pauwels-labs-main" = [
          "config-updater",
          "approve",
          "lgtm"
        ]
      },
      {
        for service in var.services : "${var.tenant_repo_org_name}/${service.name}" => [
          "approve",
          "assign",
          "cat",
          "dog",
          "hold",
          "label",
          "lgtm",
          "size",
          "trigger",
          "wip",
          "yuks"
        ]
      }
      )
  }
}
