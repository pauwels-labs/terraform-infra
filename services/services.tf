module "services" {
  source   = "./service"
  for_each = {for service in var.services : "${service.name}" => service}

  org_domain                = var.org_domain
  tenant_name               = var.tenant_name
  service_name              = each.key
  service_repo_domain       = var.tenant_repo_domain
  service_repo_org_name     = var.tenant_repo_org_name
  service_repo_visibility   = each.value.repo_visibility
  service_domain            = each.value.domain
  service_semver_range      = each.value.semver_range
  service_envs              = each.value.envs != null ? each.value.envs : var.tenant_envs
  template_name             = each.value.template_name
  container_registry_domain = var.container_registry_domain
  collapse_envs_to          = var.tenant_collapse_envs_to
}
