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
      ["../base"],
      [for service in var.services : "externalsecret-ssh-${var.tenant_name}-${local.tenant_repo_host_name}-${var.tenant_repo_org_name}-${service.name}.yaml"]
      )
  }
}
