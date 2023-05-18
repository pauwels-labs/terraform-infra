resource "keycloak_openid_client" "kubernetes" {
  realm_id                                  = keycloak_realm.pauwels_labs_main.id
  client_id                                 = "kubernetes"
  access_type                               = "CONFIDENTIAL"
  standard_flow_enabled                     = true
  implicit_flow_enabled                     = false
  direct_access_grants_enabled              = true
  service_accounts_enabled                  = true
  oauth2_device_authorization_grant_enabled = true
  backchannel_logout_session_required       = true

  root_url    = "http://localhost:8000/"
  base_url    = "http://localhost:8000/"
  admin_url   = "http://localhost:8000/"
  web_origins = ["*"]

  valid_redirect_uris = [
    "http://localhost:8000/*"
  ]
}

resource "keycloak_openid_client_default_scopes" "kubernetes" {
  realm_id  = keycloak_realm.pauwels_labs_main.id
  client_id = keycloak_openid_client.kubernetes.id

  default_scopes = [
    "profile",
    "email",
    "roles",
    "web-origins",
    keycloak_openid_client_scope.groups.name,
  ]
}
