# resource "vault_kv_secret_v2" "root" {
#   mount               = "secrets"
#   name                = "tenants/t-${var.tenant_name}/root"
#   delete_all_versions = true
#   data_json           = jsonencode({})
# }

resource "random_password" "hmac_tokens" {
  for_each = local.hmac_token_names

  length = 32
}

# resource "vault_kv_secret_v2" "hmac_tokens" {
#   for_each = local.hmac_token_names

#   mount               = "secrets"
#   name                = "tenants/t-${var.tenant_name}/webhooks/${each.key}/hmac"
#   delete_all_versions = true
#   data_json           = jsonencode({
#     "token" = random_password.hmac_tokens[each.key].result
#   })
# }

# resource "vault_kv_secret_v2" "repository_bot_token" {
#   mount               = "secrets"
#   name                = "tenants/t-${var.tenant_name}/tokens/${local.tenant_repo_host_name}/${var.tenant_repo_bot_name}"
#   delete_all_versions = true
#   data_json           = jsonencode({
#     "token" = var.tenant_repo_bot_token
#   })
# }

# resource "vault_kv_secret_v2" "repository_ssh_cd" {
#   mount               = "secrets"
#   name                = "tenants/t-${var.tenant_name}/repositories/${local.tenant_repo_host_name}/${var.tenant_repo_org_name}/${github_repository.this.name}/ssh/cd"
#   delete_all_versions = true
#   data_json           = jsonencode(
#     {
#       "identity"      = tls_private_key.this[local.cd_key_index].private_key_pem
#       "identity.pub"  = tls_private_key.this[local.cd_key_index].public_key_openssh
#       "known_hosts"   = var.known_hosts
#     }
#     )
# }

# resource "vault_kv_secret_v2" "repository_ssh_ci" {
#   mount               = "secrets"
#   name                = "tenants/t-${var.tenant_name}/repositories/${local.tenant_repo_host_name}/${var.tenant_repo_org_name}/${github_repository.this.name}/ssh/ci"
#   delete_all_versions = true
#   data_json           = jsonencode(
#     {
#       "identity"     = tls_private_key.this[local.ci_key_index].private_key_pem
#       "identity.pub" = tls_private_key.this[local.ci_key_index].public_key_openssh
#       "known_hosts"  = var.known_hosts
#     }
#     )
# }
