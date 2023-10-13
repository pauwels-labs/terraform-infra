resource "keycloak_openid_client" "infra_in_users_realm" {
  count = local.infra_realm != null ? 1 : 0

  realm_id                                   = keycloak_realm.users.id
  client_id                                  = local.infra_realm.realm
  description                                = "Allows login to common infrastructure hosted in the ${local.infra_realm.realm} realm via the users in this realm"
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
    "${local.idp_url}/realms/${local.infra_realm.realm}/broker/${var.organisation_name}/endpoint"
  ]
}

resource "keycloak_openid_client_default_scopes" "infra_in_users_realm" {
  count = local.infra_realm != null ? 1 : 0

  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.infra_in_users_realm[0].id

  default_scopes = [
    "profile",
    "email"
  ]
}

resource "keycloak_openid_client" "environments_in_users_realm" {
  for_each = var.is_guest ? local.environments_map : {}

  realm_id                                   = keycloak_realm.users.id
  client_id                                  = each.value.name
  description                                = "Allows login to the ${each.value.name} environment via the users in this realm"
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
    "${local.idp_url}/realms/${keycloak_realm.environments[each.key].realm}/broker/${var.organisation_name}/endpoint"
  ]
}

resource "keycloak_openid_client_default_scopes" "environments_in_users_realm" {
  for_each = var.is_guest ? local.environments_map : {}

  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.environments_in_users_realm[each.key].id

  default_scopes = [
    "profile",
    "email"
  ]
}

# resource "keycloak_openid_client" "services_in_environment_realms" {
#   for_each = local.environments_services_merged_map

#   realm_id                                  = keycloak_realm.environments[each.value.environment.name].id
#   client_id                                 = each.value.service.name
#   description                               = each.value.service.description
#   access_type                               = each.value.service.access_type
#   standard_flow_enabled                     = each.value.service.standard_flow_enabled
#   implicit_flow_enabled                     = each.value.service.implicit_flow_enabled
#   direct_access_grants_enabled              = each.value.service.direct_access_grants_enabled
#   service_accounts_enabled                  = each.value.service.service_accounts_enabled
#   oauth2_device_authorization_grant_enabled = each.value.service.oauth2_device_authorization_grant_enabled
#   backchannel_logout_session_required       = each.value.service.backchannel_logout_session_required
#   full_scope_allowed                        = false

#   root_url            = each.value.service.root_url
#   base_url            = each.value.service.base_url
#   valid_redirect_uris = [
#     for uri in each.value.service.valid_redirect_uris : replace(uri, "$${environment.name}", each.value.environment.name)
#   ]
# }

# resource "keycloak_openid_client_default_scopes" "services_in_environment_realms" {
#   for_each = local.environments_services_merged_map

#   realm_id  = keycloak_realm.environments[each.value.environment.name].id
#   client_id = keycloak_openid_client.services_in_environment_realms[each.key].id

#   default_scopes = [
#     "profile",
#     "email"
#   ]
# }
