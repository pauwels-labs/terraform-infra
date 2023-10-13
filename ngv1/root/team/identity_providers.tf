resource "keycloak_oidc_identity_provider" "users_in_infra_realm" {
  count = local.infra_realm != null ? 1 : 0

  realm             = local.infra_realm.realm
  alias             = var.organisation_name
  authorization_url = "${local.idp_url}/realms/${keycloak_realm.users.realm}/protocol/openid-connect/auth"
  client_id         = local.infra_realm.realm
  client_secret     = keycloak_openid_client.infra_in_users_realm[0].client_secret
  token_url         = "${local.idp_url}/realms/${keycloak_realm.users.realm}/protocol/openid-connect/token"
  display_name      = local.organisation_display_name
  store_token       = false
  user_info_url     = "${local.idp_url}/realms/${keycloak_realm.users.realm}/protocol/openid-connect/userinfo"
  logout_url        = "${local.idp_url}/realms/${keycloak_realm.users.realm}/protocol/openid-connect/logout"
  login_hint        = false
  sync_mode         = "FORCE"
  extra_config      = {
    "clientAuthMethod" = "client_secret_post"
  }
}

resource "keycloak_oidc_identity_provider" "users_in_environment_realms" {
  for_each = var.is_guest ? local.environments_map : {}

  realm             = keycloak_realm.environments[each.key].realm
  alias             = var.organisation_name
  authorization_url = "${local.idp_url}/realms/${keycloak_realm.users.realm}/protocol/openid-connect/auth"
  client_id         = keycloak_realm.environments[each.key].realm
  client_secret     = keycloak_openid_client.environments_in_users_realm[each.key].client_secret
  token_url         = "${local.idp_url}/realms/${keycloak_realm.users.realm}/protocol/openid-connect/token"
  display_name      = local.organisation_display_name
  store_token       = false
  user_info_url     = "${local.idp_url}/realms/${keycloak_realm.users.realm}/protocol/openid-connect/userinfo"
  logout_url        = "${local.idp_url}/realms/${keycloak_realm.users.realm}/protocol/openid-connect/logout"
  login_hint        = false
  sync_mode         = "FORCE"
  extra_config      = {
    "clientAuthMethod" = "client_secret_post"
  }
}

# resource "keycloak_attribute_to_role_identity_provider_mapper" "root" {
#   for_each = var.is_root ? local.environments_map : {}

#   realm                   = keycloak_realm.environments[each.value.name].id
#   name                    = "root-mapper"
#   identity_provider_alias = keycloak_oidc_identity_provider.users[each.value.name].alias
#   role                    = "root"
#   claim_name              = "roles"
#   claim_value             = "root"
#   extra_config            = {
#     syncMode = "FORCE"
#   }
# }

# resource "keycloak_attribute_to_role_identity_provider_mapper" "environment_service_team_admin" {
#   for_each = local.environments_services_teams_merged_map

#   realm                   = keycloak_realm.environments[each.value.environment.name].id
#   name                    = "${each.value.service.name}-${each.value.team.name}-admin-mapper"
#   identity_provider_alias = keycloak_oidc_identity_provider.users[each.value.environment.name].alias
#   role                    = "${each.value.service.name}.${keycloak_role.environment_service_team_admin_in_environment_realms[each.key].name}"
#   claim_name              = "roles"
#   claim_value             = "${each.value.service.name}-${each.value.team.name}-admin"
#   extra_config            = {
#     syncMode = "FORCE"
#   }
# }

# resource "keycloak_attribute_to_role_identity_provider_mapper" "environment_service_team_writer" {
#   for_each = local.environments_services_teams_merged_map

#   realm                   = keycloak_realm.environments[each.value.environment.name].id
#   name                    = "${each.value.service.name}-${each.value.team.name}-writer-mapper"
#   identity_provider_alias = keycloak_oidc_identity_provider.users[each.value.environment.name].alias
#   role                    = "${each.value.service.name}.${keycloak_role.environment_service_team_writer_in_environment_realms[each.key].name}"
#   claim_name              = "roles"
#   claim_value             = "${each.value.service.name}-${each.value.team.name}-writer"
#   extra_config            = {
#     syncMode = "FORCE"
#   }
# }

# resource "keycloak_attribute_to_role_identity_provider_mapper" "environment_service_team_reader" {
#   for_each = local.environments_services_teams_merged_map

#   realm                   = keycloak_realm.environments[each.value.environment.name].id
#   name                    = "${each.value.service.name}-${each.value.team.name}-reader-mapper"
#   identity_provider_alias = keycloak_oidc_identity_provider.users[each.value.environment.name].alias
#   role                    = "${each.value.service.name}.${keycloak_role.environment_service_team_reader_in_environment_realms[each.key].name}"
#   claim_name              = "roles"
#   claim_value             = "${each.value.service.name}-${each.value.team.name}-reader"
#   extra_config            = {
#     syncMode = "FORCE"
#   }
# }
