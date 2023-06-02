resource "vault_kv_secret_v2" "repository_ssh_cd" {
  mount               = "secrets"
  name                = "tenants/t-${local.full_tenant_name}/repositories/${var.repository_host}/${var.org_name}/${var.repository_name}/ssh/cd"
  delete_all_versions = true
  data_json           = jsonencode(
    {
      "identity"      = tls_private_key.this[local.cd_key_index].private_key_pem
      "identity.pub"  = tls_private_key.this[local.cd_key_index].public_key_openssh
      "known_hosts"   = var.known_hosts
    }
    )
}

resource "vault_kv_secret_v2" "repository_ssh_ci" {
  mount               = "secrets"
  name                = "tenants/t-${local.full_tenant_name}/repositories/${var.repository_host}/${var.org_name}/${var.repository_name}/ssh/ci"
  delete_all_versions = true
  data_json           = jsonencode(
    {
      "identity"     = tls_private_key.this[local.ci_key_index].private_key_pem
      "identity.pub" = tls_private_key.this[local.ci_key_index].public_key_openssh
      "known_hosts"  = var.known_hosts
    }
    )
}

resource "vault_kv_secret_v2" "config" {
  count               = var.enable_vault_config_env_suffixes ? 2 * length(local.environments) : 1 + length(local.environments)

  mount               = "secrets"
  name                = "tenants/t-${local.full_tenant_name}/configs/${count.index < local.base_config_count ? "base" : local.environments[count.index - local.base_config_count]}/${var.repository_name}${var.enable_vault_config_env_suffixes ? "-${local.environments[count.index % length(local.environments)]}" : ""}/config"
  delete_all_versions = true
  data_json           = jsonencode(
    {
      "config.yaml" = ""
    }
    )

  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

resource "vault_kv_secret_v2" "env" {
  count               = var.enable_vault_config_env_suffixes ? 2 * length(local.environments) : 1 + length(local.environments)

  mount               = "secrets"
  name                = "tenants/t-${local.full_tenant_name}/configs/${count.index < local.base_config_count ? "base" : local.environments[count.index - local.base_config_count]}/${var.repository_name}${var.enable_vault_config_env_suffixes ? "-${local.environments[count.index % length(local.environments)]}" : ""}/env"
  delete_all_versions = true
  data_json           = jsonencode(
    {
      "APPCFG_PLACEHOLDER" = ""
    }
    )

  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

data "vault_kv_secret_v2" "hmac" {
  mount = "secrets"
  name  = "tenants/t-${local.full_tenant_name}/webhooks/${var.hmac_token_name}/hmac"
}
