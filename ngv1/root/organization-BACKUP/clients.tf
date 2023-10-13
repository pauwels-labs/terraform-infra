# resource "keycloak_openid_client" "environments" {
#   for_each = keycloak_realm.environments

#   realm_id                                   = keycloak_realm.users.id
#   client_id                                  = "realm-${each.value.realm}"
#   description                                = "Allows login to the ${each.value.realm} realm via the users in this realm"
#   access_type                                = "CONFIDENTIAL"
#   standard_flow_enabled                      = true
#   implicit_flow_enabled                      = false
#   direct_access_grants_enabled               = false
#   service_accounts_enabled                   = false
#   oauth2_device_authorization_grant_enabled  = false
#   backchannel_logout_session_required        = true
#   backchannel_logout_revoke_offline_sessions = true
#   full_scope_allowed                         = false

#   root_url    = local.idp_url
#   base_url    = local.idp_url

#   valid_redirect_uris = [
#     "${local.idp_url}/realms/${each.value.realm}/broker/${var.organisation_name}/endpoint"
#   ]
# }

# resource "keycloak_openid_client_default_scopes" "environments" {
#   for_each = keycloak_realm.environments

#   realm_id  = keycloak_realm.users.id
#   client_id = keycloak_openid_client.environments[each.key].id

#   default_scopes = [
#     "profile",
#     "email"
#   ]
# }

# resource "keycloak_openid_client" "services" {
#   for_each = local.services_map

#   realm_id                                  = keycloak_realm.infra.id
#   client_id                                 = each.value.name
#   description                               = each.value.description
#   access_type                               = each.value.access_type
#   standard_flow_enabled                     = each.value.standard_flow_enabled
#   implicit_flow_enabled                     = each.value.implicit_flow_enabled
#   direct_access_grants_enabled              = each.value.direct_access_grants_enabled
#   service_accounts_enabled                  = each.value.service_accounts_enabled
#   oauth2_device_authorization_grant_enabled = each.value.oauth2_device_authorization_grant_enabled
#   backchannel_logout_session_required       = each.value.backchannel_logout_session_required
#   full_scope_allowed                        = false

#   root_url            = each.value.root_url
#   base_url            = each.value.base_url
#   valid_redirect_uris = each.value.valid_redirect_uris
# }

# resource "keycloak_openid_client_default_scopes" "services" {
#   for_each = local.services_map

#   realm_id  = keycloak_realm.infra.id
#   client_id = keycloak_openid_client.services.id

#   default_scopes = [
#     "profile",
#     "email"
#   ]
# }
