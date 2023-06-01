locals {
  full_tenant_name    = "${var.org_name}-${var.tenant_name}"
  environments        = [
    "dev",
    "staging",
    "prod"
  ]
  base_config_count   = var.enable_vault_config_env_suffixes ? length(local.environments) : 1
  ci_webhook_url      = "https://${var.ci_webhook_domain}/${local.full_tenant_name}"
  key_count           = length(local.deploy_keys)
  cd_key_index        = index(local.deploy_keys.*.name, "cd")
  ci_key_index        = index(local.deploy_keys.*.name, "cd")
  deploy_keys         = concat(local.deploy_keys_default, var.additional_deploy_keys)
  deploy_keys_default = [
    {
      name = "ci"
      rw   = true
    },
    {
      name = "cd"
      rw   = false
    }
  ]

  workload_file = file("${path.module}/workload.yaml")
  externalsecret_ssh_cd_file = file("${path.module}/externalsecret-ssh-cd.yaml")
  externalsecret_ssh_ci_file = file("${path.module}/externalsecret-ssh-ci.yaml")
  workload_file_replaced = replace(replace(replace(replace(replace(local.workload_file, "TF_REPLACE_NAME", var.repository_name), "TF_REPLACE_TENANT_NAME", local.full_tenant_name), "TF_REPLACE_REPOSITORY_HOST", var.repository_host), "TF_REPLACE_ORG_NAME", var.org_name), "TF_REPLACE_CONTAINER_REGISTRY_DOMAIN", var.container_registry_domain)
  externalsecret_ssh_cd_file_replaced = replace(replace(replace(replace(replace(local.externalsecret_ssh_cd_file, "TF_REPLACE_NAME", var.repository_name), "TF_REPLACE_TENANT_NAME", local.full_tenant_name), "TF_REPLACE_REPOSITORY_HOST", var.repository_host), "TF_REPLACE_ORG_NAME", var.org_name), "TF_REPLACE_CONTAINER_REGISTRY_DOMAIN", var.container_registry_domain)
  externalsecret_ssh_ci_file_replaced = replace(replace(replace(replace(replace(local.externalsecret_ssh_ci_file, "TF_REPLACE_NAME", var.repository_name), "TF_REPLACE_TENANT_NAME", local.full_tenant_name), "TF_REPLACE_REPOSITORY_HOST", var.repository_host), "TF_REPLACE_ORG_NAME", var.org_name), "TF_REPLACE_CONTAINER_REGISTRY_DOMAIN", var.container_registry_domain)
}
