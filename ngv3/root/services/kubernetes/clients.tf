resource "keycloak_openid_client" "this" {
  for_each = var.cluster_names

  realm_id                                  = data.keycloak_realm.shared.id
  client_id                                 = "kubernetes-${each.key}"
  description                               = "Client for accessing the ${each.key} Kubernetes cluster in the ${var.environment_name}/${var.cluster_region} environment"
  access_type                               = "PUBLIC"
  standard_flow_enabled                     = true
  implicit_flow_enabled                     = false
  direct_access_grants_enabled              = false
  service_accounts_enabled                  = false
  oauth2_device_authorization_grant_enabled = false
  backchannel_logout_session_required       = true
  full_scope_allowed                        = false
  pkce_code_challenge_method                = "S256"

  root_url            = "http://localhost:8000/"
  base_url            = "http://localhost:8000/"
  valid_redirect_uris = [
    "http://localhost:8000/*"
  ]
}

resource "keycloak_openid_client_default_scopes" "this" {
  for_each = var.cluster_names

  realm_id  = data.keycloak_realm.shared.id
  client_id = keycloak_openid_client.this[each.key].id

  default_scopes = [
    "profile",
    "email"
  ]
}
