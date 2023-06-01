module "example-service" {
  source = "./service"

  org_name                         = var.github_org_name
  tenant_name                      = "main"
  repository_name                  = "example-service"
  template_name                    = "template-rust-warp"

  container_registry_domain        = var.container_registry_domain
  ci_webhook_domain                = var.ci_webhook_domain
  enable_vault_config_env_suffixes = true
}
