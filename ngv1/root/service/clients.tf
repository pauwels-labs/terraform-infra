resource "keycloak_openid_client" "this" {
  for_each = var.separate_clients_per_env ? local.environments_services_merged_map : {"unified": {}}

  realm_id                                  = data.keycloak_realm.infra.id
  client_id                                 = each.value.name != null ? "${var.service_name}-${each.value.name}" : var.service_name
  description                               = var.service_description
  access_type                               = var.oidc_client_config.access_type
  standard_flow_enabled                     = var.oidc_client_config.standard_flow_enabled
  implicit_flow_enabled                     = var.oidc_client_config.implicit_flow_enabled
  direct_access_grants_enabled              = var.oidc_client_config.direct_access_grants_enabled
  service_accounts_enabled                  = var.oidc_client_config.service_accounts_enabled
  oauth2_device_authorization_grant_enabled = var.oidc_client_config.oauth2_device_authorization_grant_enabled
  backchannel_logout_session_required       = var.oidc_client_config.backchannel_logout_session_required
  full_scope_allowed                        = false

  root_url            = var.oidc_client_config.root_url
  base_url            = var.oidc_client_config.base_url
  valid_redirect_uris = var.oidc_client_config.valid_redirect_uris
}

resource "keycloak_openid_client_default_scopes" "this" {
  for_each = var.separate_clients_per_env ? local.environments_services_merged_map : {"unified": {}}

  realm_id  = data.keycloak_realm.infra.id
  client_id = keycloak_openid_client.this[each.key].id

  default_scopes = [
    "profile",
    "email"
  ]
}
