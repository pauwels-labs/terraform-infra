locals {
  full_tenant_name = "${var.org_name}-${var.tenant_name}"

  kustomization_resources_workload_yaml = distinct(concat(local.kustomization_base_yaml.resources, [for service in var.services : "${service.name}.yaml"], [for service in var.services : "externalsecret-ssh-${local.full_tenant_name}-${service.repository_host}-${var.org_name}-${service.name}.yaml"]))
  kustomization_resources_infra_yaml    = distinct(concat(local.kustomization_base_yaml.resources, [for service in var.services : "externalsecret-ssh-${local.full_tenant_name}-${service.repository_host}-${var.org_name}-${service.name}.yaml"]))
  kustomization_base_yaml               = yamldecode(file("${path.module}/kustomization.yaml"))
  kustomization_workload_yaml           = merge(local.kustomization_base_yaml, {
    "namespace" = "t-${local.full_tenant_name}"
    "resources" = local.kustomization_resources_workload_yaml
  })
  kustomization_infra_yaml             = merge(local.kustomization_base_yaml, {
    "namespace" = "t-${local.full_tenant_name}"
    "resources" = local.kustomization_resources_infra_yaml
  })
}
