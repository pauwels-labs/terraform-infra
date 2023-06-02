module "services" {
  source   = "./service"
  for_each = {for service in var.services : "${service.name}" => service}

  org_name                         = var.org_name
  tenant_name                      = var.tenant_name
  repository_host                  = each.value.repository_host
  repository_name                  = each.key
  template_name                    = "template-${each.value.template_name}"

  container_registry_domain        = var.container_registry_domain
  ci_webhook_domain                = var.ci_webhook_domain
  enable_vault_config_env_suffixes = true
}
