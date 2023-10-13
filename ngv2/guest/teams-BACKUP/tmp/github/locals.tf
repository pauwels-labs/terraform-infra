locals {
  vault_url = trim(var.vault_url, "/")

  environments_map = { for environment in var.environments : environment.name => environment }

  hmac_token_names = toset(concat(["primary"], tolist(var.additional_hmac_tokens)))

  key_count           = length(local.deploy_keys)
  cd_key_index        = index(local.deploy_keys.*.name, "cd")
  ci_key_index        = index(local.deploy_keys.*.name, "ci")
  deploy_keys         = concat(local.deploy_keys_default, var.additional_deploy_keys)
  deploy_keys_default = [
    {
      name = "ci"
      rw   = true
    },
    {
      name = "cd"
      rw   = true
    }
  ]
}
