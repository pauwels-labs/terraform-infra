resource "keycloak_openid_client" "shared_in_users_realm" {
  realm_id                                   = keycloak_realm.users.id
  client_id                                  = var.root_shared_realm_id
  description                                = "Allows login to the root organisation's shared infrastructure realm via the ${keycloak_realm.users.id} realm"
  access_type                                = "CONFIDENTIAL"
  standard_flow_enabled                      = true
  implicit_flow_enabled                      = false
  direct_access_grants_enabled               = false
  service_accounts_enabled                   = false
  oauth2_device_authorization_grant_enabled  = false
  backchannel_logout_session_required        = true
  backchannel_logout_revoke_offline_sessions = true
  full_scope_allowed                         = false
  pkce_code_challenge_method                 = "S256"

  root_url            = local.idp_url
  base_url            = local.idp_url
  valid_redirect_uris = [
    "${local.idp_url}/realms/${var.root_shared_realm_id}/broker/${var.organisation_name}/endpoint"
  ]
}

resource "keycloak_openid_client_default_scopes" "shared_in_users_realm" {
  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.shared_in_users_realm.id

  default_scopes = [
    "profile",
    "email"
  ]
}
