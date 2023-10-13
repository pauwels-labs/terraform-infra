resource "random_password" "hmac_tokens" {
  for_each = local.hmac_token_names

  length = 32
}

resource "vault_kv_secret_v2" "hmac_tokens" {
  for_each = local.hmac_token_names

  mount               = var.organisation_name
  name                = "teams/${var.team_name}/webhooks/${each.key}/hmac"
  delete_all_versions = true
  data_json           = jsonencode({
    "token" = random_password.hmac_tokens[each.key].result
  })
}

resource "vault_kv_secret_v2" "repository_bot_token" {
  mount               = var.organisation_name
  name                = "teams/${var.team_name}/tokens/${var.repository_domain}/${var.repository_bot_name}"
  delete_all_versions = true
  data_json           = jsonencode({
    "token" = "TOKEN MUST BE COPIED INTO VAULT"
  })
}

resource "vault_kv_secret_v2" "repository_ssh_cd" {
  mount               = var.organisation_name
  name                = "teams/${var.team_name}/repositories/${var.repository_domain}/${var.organisation_name}/team-${var.team_name}/ssh/cd"
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
  mount               = var.organisation_name
  name                = "teams/${var.team_name}/repositories/${var.repository_domain}/${var.organisation_name}/team-${var.team_name}/ssh/ci"
  delete_all_versions = true
  data_json           = jsonencode(
    {
      "identity"     = tls_private_key.this[local.ci_key_index].private_key_pem
      "identity.pub" = tls_private_key.this[local.ci_key_index].public_key_openssh
      "known_hosts"  = var.known_hosts
    }
    )
}
