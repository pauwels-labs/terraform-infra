resource "keycloak_oidc_identity_provider" "shared" {
  realm             = var.root_shared_realm_id
  alias             = var.organisation_name
  authorization_url = "${local.idp_url}/realms/${keycloak_realm.users.id}/protocol/openid-connect/auth"
  client_id         = keycloak_openid_client.shared_in_users_realm.client_id
  client_secret     = keycloak_openid_client.shared_in_users_realm.client_secret
  token_url         = "${local.idp_url}/realms/${keycloak_realm.users.id}/protocol/openid-connect/token"
  display_name      = keycloak_realm.users.display_name
  store_token       = false
  user_info_url     = "${local.idp_url}/realms/${keycloak_realm.users.id}/protocol/openid-connect/userinfo"
  logout_url        = "${local.idp_url}/realms/${keycloak_realm.users.id}/protocol/openid-connect/logout"
  login_hint        = false
  sync_mode         = "FORCE"
  extra_config      = {
    "clientAuthMethod" = "client_secret_post"
    "pkceEnabled"      = true
    "pkceMethod"       = "S256"
  }
}
