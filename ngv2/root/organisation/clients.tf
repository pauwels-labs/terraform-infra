resource "keycloak_openid_client" "shared_infra_in_users_realm" {
  count = var.is_root && !var.is_guest ? 1 : 0

  realm_id                                   = keycloak_realm.users.id
  client_id                                  = local.realm_shared_infra[0].realm
  description                                = "Allows login to the ${local.realm_shared_infra[0].realm} realm via the users in this realm"
  access_type                                = "CONFIDENTIAL"
  standard_flow_enabled                      = true
  implicit_flow_enabled                      = false
  direct_access_grants_enabled               = false
  service_accounts_enabled                   = false
  oauth2_device_authorization_grant_enabled  = false
  backchannel_logout_session_required        = true
  backchannel_logout_revoke_offline_sessions = true
  full_scope_allowed                         = false

  root_url    = local.idp_url
  base_url    = local.idp_url

  valid_redirect_uris = [
    "${local.idp_url}/realms/${local.realm_shared_infra[0].realm}/broker/${var.organisation_name}/endpoint"
  ]
}

resource "keycloak_openid_client_default_scopes" "shared_infra_in_users_realm" {
  count = var.is_root && !var.is_guest ? 1 : 0

  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.shared_infra_in_users_realm[0].id

  default_scopes = [
    "profile",
    "email"
  ]
}

resource "keycloak_openid_client" "environment_infras_in_users_realm" {
  for_each = var.is_root && !var.is_guest ? local.environments_map : {}

  realm_id                                   = keycloak_realm.users.id
  client_id                                  = local.realm_environment_infras[each.key].realm
  description                                = "Allows login to the ${local.realm_environment_infras[each.key].realm} realm via the users in this realm"
  access_type                                = "CONFIDENTIAL"
  standard_flow_enabled                      = true
  implicit_flow_enabled                      = false
  direct_access_grants_enabled               = false
  service_accounts_enabled                   = false
  oauth2_device_authorization_grant_enabled  = false
  backchannel_logout_session_required        = true
  backchannel_logout_revoke_offline_sessions = true
  full_scope_allowed                         = false

  root_url    = local.idp_url
  base_url    = local.idp_url

  valid_redirect_uris = [
    "${local.idp_url}/realms/${local.realm_environment_infras[each.key].realm}/broker/${var.organisation_name}/endpoint"
  ]
}

resource "keycloak_openid_client_default_scopes" "environment_infras_in_users_realm" {
  for_each = var.is_root && !var.is_guest ? local.environments_map : {}

  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.environment_infras_in_users_realm[each.key].id

  default_scopes = [
    "profile",
    "email"
  ]
}
