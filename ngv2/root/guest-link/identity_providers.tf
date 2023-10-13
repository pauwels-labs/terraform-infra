resource "keycloak_oidc_identity_provider" "shared_infra" {
  realm             = data.keycloak_realm.root_shared_infra.realm
  alias             = var.guest_organisation_name
  authorization_url = "${local.idp_url}/realms/${data.keycloak_realm.guest_users.realm}/protocol/openid-connect/auth"
  client_id         = data.keycloak_openid_client.guest_shared_infra_in_users_realm.client_id
  client_secret     = data.keycloak_openid_client.guest_shared_infra_in_users_realm.client_secret
  token_url         = "${local.idp_url}/realms/${data.keycloak_realm.guest_users.realm}/protocol/openid-connect/token"
  display_name      = data.keycloak_realm.guest_users.display_name
  store_token       = false
  user_info_url     = "${local.idp_url}/realms/${data.keycloak_realm.guest_users.realm}/protocol/openid-connect/userinfo"
  logout_url        = "${local.idp_url}/realms/${data.keycloak_realm.guest_users.realm}/protocol/openid-connect/logout"
  login_hint        = false
  sync_mode         = "FORCE"
  extra_config      = {
    "clientAuthMethod" = "client_secret_post"
  }
}

resource "keycloak_oidc_identity_provider" "environment_infras" {
  for_each = local.environments_map

  realm             = data.keycloak_realm.root_environment_infras[each.key].realm
  alias             = var.guest_organisation_name
  authorization_url = "${local.idp_url}/realms/${data.keycloak_realm.guest_users.realm}/protocol/openid-connect/auth"
  client_id         = data.keycloak_openid_client.guest_environment_infras_in_users_realm[each.key].client_id
  client_secret     = data.keycloak_openid_client.guest_environment_infras_in_users_realm[each.key].client_secret
  token_url         = "${local.idp_url}/realms/${data.keycloak_realm.guest_users.realm}/protocol/openid-connect/token"
  display_name      = data.keycloak_realm.guest_users.display_name
  store_token       = false
  user_info_url     = "${local.idp_url}/realms/${data.keycloak_realm.guest_users.realm}/protocol/openid-connect/userinfo"
  logout_url        = "${local.idp_url}/realms/${data.keycloak_realm.guest_users.realm}/protocol/openid-connect/logout"
  login_hint        = false
  sync_mode         = "FORCE"
  extra_config      = {
    "clientAuthMethod" = "client_secret_post"
  }
}
