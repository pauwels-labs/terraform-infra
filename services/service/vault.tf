resource "vault_kv_secret_v2" "repository_ssh_cd" {
  mount               = "secrets"
  name                = "tenants/t-${var.tenant_name}/repositories/${local.service_repo_host_name}/${var.service_repo_org_name}/${var.service_name}/ssh/cd"
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
  name                = "tenants/t-${var.tenant_name}/repositories/${local.service_repo_host_name}/${var.service_repo_org_name}/${var.service_name}/ssh/ci"
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
  count               = local.collapse_envs ? 2 * length(var.service_envs) : 1 + length(var.service_envs)

  mount               = "secrets"
  name                = "tenants/t-${var.tenant_name}/configs/${count.index < local.base_config_count ? "base" : var.service_envs[count.index - local.base_config_count].name}/${var.service_name}${local.collapse_envs ? "-${var.service_envs[count.index % length(var.service_envs)].name}" : ""}/config"
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
  count               = local.collapse_envs ? 2 * length(var.service_envs) : 1 + length(var.service_envs)

  mount               = "secrets"
  name                = "tenants/t-${var.tenant_name}/configs/${count.index < local.base_config_count ? "base" : var.service_envs[count.index - local.base_config_count].name}/${var.service_name}${local.collapse_envs ? "-${var.service_envs[count.index % length(var.service_envs)].name}" : ""}/env"
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
  name  = "tenants/t-${var.tenant_name}/webhooks/${var.hmac_token_name}/hmac"
}
