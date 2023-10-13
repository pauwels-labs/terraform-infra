resource "vault_jwt_auth_backend_role" "admin" {
  for_each = local.environments_map

  backend               = vault_jwt_auth_backend.environments[each.value.name].path
  role_name             = "admin"
  role_type             = "oidc"
  user_claim            = "sub"
  bound_claims          = {
    aud = coalesce(each.value.client_id, "vault")
    azp = coalesce(each.value.client_id, "vault")
  }
  groups_claim          = "roles"
  allowed_redirect_uris = [
    "${local.vault_url}/ui/vault/auth/${vault_jwt_auth_backend.environments[each.value.name].path}/oidc/callback",
    "http://localhost:8250/oidc/callback"
  ]
}

resource "vault_jwt_auth_backend_role" "writer" {
  for_each              = local.environments_map

  backend               = vault_jwt_auth_backend.environments[each.value.name].path
  role_name             = "writer"
  role_type             = "oidc"
  user_claim            = "sub"
  bound_claims          = {
    aud = coalesce(each.value.client_id, "vault")
    azp = coalesce(each.value.client_id, "vault")
  }
  groups_claim          = "roles"
  allowed_redirect_uris = [
    "${local.vault_url}/ui/vault/auth/${vault_jwt_auth_backend.environments[each.value.name].path}/oidc/callback",
    "http://localhost:8250/oidc/callback"
  ]
}

resource "vault_jwt_auth_backend_role" "reader" {
  for_each = local.environments_map

  backend               = vault_jwt_auth_backend.environments[each.value.name].path
  role_name             = "reader"
  role_type             = "oidc"
  user_claim            = "sub"
  bound_claims          = {
    aud = coalesce(each.value.client_id, "vault")
    azp = coalesce(each.value.client_id, "vault")
  }
  groups_claim          = "roles"
  allowed_redirect_uris = [
    "${local.vault_url}/ui/vault/auth/${vault_jwt_auth_backend.environments[each.value.name].path}/oidc/callback",
    "http://localhost:8250/oidc/callback"
  ]
}
