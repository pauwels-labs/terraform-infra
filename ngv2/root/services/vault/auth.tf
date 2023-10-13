resource "vault_jwt_auth_backend" "this" {
  count = var.is_root ? 1 : 0

  path                = var.organisation_name
  type                = "oidc"
  description         = "OIDC auth for the ${data.keycloak_realm.shared_infra.realm} realm"
  oidc_discovery_url  = "${local.idp_url}/realms/${data.keycloak_realm.shared_infra.realm}"
  oidc_client_id      = keycloak_openid_client.vault_in_shared_infra_realm[0].client_id
  oidc_client_secret  = keycloak_openid_client.vault_in_shared_infra_realm[0].client_secret
  oidc_response_mode  = "query"
  oidc_response_types = [
    "code"
  ]
  bound_issuer        = "${local.idp_url}/realms/${data.keycloak_realm.shared_infra.realm}"
  default_role        = "default"

  tune {
    default_lease_ttl  = "72h"
    max_lease_ttl      = "72h"
    listing_visibility = "unauth"
    token_type         = "default-service"
  }
}

resource "vault_jwt_auth_backend_role" "default" {
  count = var.is_root ? 1 : 0

  backend               = vault_jwt_auth_backend.this[0].path
  role_name             = "default"
  role_type             = "oidc"
  user_claim            = "sub"
  bound_claims          = {
    aud = keycloak_openid_client.vault_in_shared_infra_realm[0].client_id
    azp = keycloak_openid_client.vault_in_shared_infra_realm[0].client_id
  }
  groups_claim          = "roles"
  allowed_redirect_uris = [
    "${local.vault_url}/ui/vault/auth/${vault_jwt_auth_backend.this[0].path}/oidc/callback",
    "http://localhost:8250/oidc/callback"
  ]
}

data "vault_auth_backend" "this" {
  count = var.is_root ? 0 : 1

  path = var.root_organisation_name
}
