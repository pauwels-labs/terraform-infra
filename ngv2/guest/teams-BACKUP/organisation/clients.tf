resource "keycloak_openid_client" "environments_in_users_realm" {
  for_each = local.environments_map

  realm_id                                   = data.keycloak_realm.users.id
  client_id                                  = data.keycloak_realm.environments[each.key].realm
  description                                = "Allows login to the ${data.keycloak_realm.environments[each.key].realm} realm via the users in this realm"
  access_type                                = "CONFIDENTIAL"
  standard_flow_enabled                      = true
  implicit_flow_enabled                      = false
  direct_access_grants_enabled               = false
  service_accounts_enabled                   = false
  oauth2_device_authorization_grant_enabled  = false
  backchannel_logout_session_required        = true
  backchannel_logout_revoke_offline_sessions = true
  full_scope_allowed                         = false

  root_url = local.idp_url
  base_url = local.idp_url

  valid_redirect_uris = [
    "${local.idp_url}/realms/${data.keycloak_realm.environments[each.key].realm}/broker/${var.organisation_name}/endpoint"
  ]
}

resource "keycloak_openid_client_default_scopes" "environments_in_users_realm" {
  for_each = local.environments_map

  realm_id  = data.keycloak_realm.users.id
  client_id = keycloak_openid_client.environments_in_users_realm[each.key].id

  default_scopes = [
    "profile",
    "email"
  ]
}

resource "keycloak_openid_client" "shared_infra_in_users_realm" {
  count = local.link_to_root_organisation ? 1 : 0

  realm_id                                   = data.keycloak_realm.users.id
  client_id                                  = "${var.root_organisation_name}-shared-infra"
  description                                = "Allows login to the ${var.root_organisation_name}-shared-infra realm via the users in this realm"
  access_type                                = "CONFIDENTIAL"
  standard_flow_enabled                      = true
  implicit_flow_enabled                      = false
  direct_access_grants_enabled               = false
  service_accounts_enabled                   = false
  oauth2_device_authorization_grant_enabled  = false
  backchannel_logout_session_required        = true
  backchannel_logout_revoke_offline_sessions = true
  full_scope_allowed                         = false

  root_url = local.idp_url
  base_url = local.idp_url

  valid_redirect_uris = [
    "${local.idp_url}/realms/${var.root_organisation_name}-shared-infra/broker/${var.organisation_name}/endpoint"
  ]
}

resource "keycloak_openid_client_default_scopes" "shared_infra_in_users_realm" {
  count = local.link_to_root_organisation ? 1 : 0

  realm_id  = data.keycloak_realm.users.id
  client_id = keycloak_openid_client.shared_infra_in_users_realm[0].id

  default_scopes = [
    "profile",
    "email"
  ]
}

resource "keycloak_openid_client" "environment_infras_in_users_realm" {
  for_each = local.link_to_root_organisation ? local.environments_map : {}

  realm_id                                   = data.keycloak_realm.users.id
  client_id                                  = "${var.root_organisation_name}-${each.value.name}-infra"
  description                                = "Allows login to the ${var.root_organisation_name}-${each.value.name}-infra realm via the users in this realm"
  access_type                                = "CONFIDENTIAL"
  standard_flow_enabled                      = true
  implicit_flow_enabled                      = false
  direct_access_grants_enabled               = false
  service_accounts_enabled                   = false
  oauth2_device_authorization_grant_enabled  = false
  backchannel_logout_session_required        = true
  backchannel_logout_revoke_offline_sessions = true
  full_scope_allowed                         = false

  root_url = local.idp_url
  base_url = local.idp_url

  valid_redirect_uris = [
    "${local.idp_url}/realms/${var.root_organisation_name}-${each.value.name}-infra/broker/${var.organisation_name}/endpoint"
  ]
}

resource "keycloak_openid_client_default_scopes" "environment_infras_in_users_realm" {
  for_each = local.link_to_root_organisation ? local.environments_map : {}

  realm_id  = data.keycloak_realm.users.id
  client_id = keycloak_openid_client.environment_infras_in_users_realm[each.key].id

  default_scopes = [
    "profile",
    "email"
  ]
}
