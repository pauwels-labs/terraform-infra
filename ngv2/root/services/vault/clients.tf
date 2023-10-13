resource "keycloak_openid_client" "vault_in_shared_infra_realm" {
  count = var.is_root ? 1 : 0

  realm_id                                   = data.keycloak_realm.shared_infra.id
  client_id                                  = "vault"
  description                                = "Allows login to the vault instance shared across all environments"
  access_type                                = "CONFIDENTIAL"
  standard_flow_enabled                      = true
  implicit_flow_enabled                      = false
  direct_access_grants_enabled               = false
  service_accounts_enabled                   = false
  oauth2_device_authorization_grant_enabled  = false
  backchannel_logout_session_required        = true
  backchannel_logout_revoke_offline_sessions = true
  full_scope_allowed                         = false

  root_url = local.vault_url
  base_url = local.vault_url

  valid_redirect_uris = [
    "/ui/vault/auth/${var.organisation_name}/oidc/callback",
    "http://localhost:8250/oidc/callback"
  ]
}

resource "keycloak_openid_client_default_scopes" "vault_in_shared_infra_realm" {
  count = var.is_root ? 1 : 0

  realm_id  = data.keycloak_realm.shared_infra.id
  client_id = keycloak_openid_client.vault_in_shared_infra_realm[0].id

  default_scopes = [
    "profile",
    "email"
  ]
}

data "keycloak_openid_client" "vault_in_shared_infra_realm" {
  count = var.is_root ? 0 : 1

  realm_id  = data.keycloak_realm.shared_infra.id
  client_id = "vault"
}
