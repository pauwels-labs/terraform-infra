resource "keycloak_role" "environment_root_in_user_realm" {
  for_each = var.is_root ? local.environments_map : {}

  realm_id    = keycloak_realm.users.id
  client_id   = keycloak_openid_client.environments[each.value.name].id
  name        = "root"
  description = "The root administrator has full superadmin access to every component of the ${each.value.name} environment"
}

resource "keycloak_role" "environment_service_team_admin_in_user_realm" {
  for_each = local.environments_services_teams_merged_map

  realm_id    = keycloak_realm.users.id
  client_id   = keycloak_openid_client.environments[each.value.environment.name].id
  name        = "${each.value.service.name}-${each.value.team.name}-admin"
  description = "Administrator of the ${each.value.service.name} service within the ${each.value.team.name} team in the ${each.value.environment.name} environment"
}

resource "keycloak_role" "environment_service_team_writer_in_user_realm" {
  for_each = local.environments_services_teams_merged_map

  realm_id    = keycloak_realm.users.id
  client_id   = keycloak_openid_client.environments[each.value.environment.name].id
  name        = "${each.value.service.name}-${each.value.team.name}-writer"
  description = "Writer of the ${each.value.service.name} service within the ${each.value.team.name} team in the ${each.value.environment.name} environment"
}

resource "keycloak_role" "environment_service_team_reader_in_user_realm" {
  for_each = local.environments_services_teams_merged_map

  realm_id    = keycloak_realm.users.id
  client_id   = keycloak_openid_client.environments[each.value.environment.name].id
  name        = "${each.value.service.name}-${each.value.team.name}-reader"
  description = "Reader of the ${each.value.service.name} service within the ${each.value.team.name} team in the ${each.value.environment.name} environment"
}

resource "keycloak_role" "environment_root_in_environment_realms" {
  for_each = var.is_root ? local.environments_map : {}

  realm_id    = keycloak_realm.environments[each.value.name].id
  name        = "root"
  description = "The root administrator has full superadmin access to every component of the ${each.value.name} environment"
}

resource "keycloak_role" "environment_service_team_admin_in_environment_realms" {
  for_each = local.environments_services_teams_merged_map

  realm_id    = keycloak_realm.environments[each.value.environment.name].id
  client_id   = keycloak_openid_client.services_in_environment_realms["${each.value.environment.name}-${each.value.service.name}"].id
  name        = "${var.organisation_name}-${each.value.team.name}-admin"
  description = "Administrator of the ${each.value.service.name} service within the ${each.value.team.name} team of the ${var.organisation_name} organisation in the ${each.value.environment.name} environment"
}

resource "keycloak_role" "environment_service_team_writer_in_environment_realms" {
  for_each = local.environments_services_teams_merged_map

  realm_id    = keycloak_realm.environments[each.value.environment.name].id
  client_id   = keycloak_openid_client.services_in_environment_realms["${each.value.environment.name}-${each.value.service.name}"].id
  name        = "${var.organisation_name}-${each.value.team.name}-writer"
  description = "Writer of the ${each.value.service.name} service within the ${each.value.team.name} team of the ${var.organisation_name} organisation in the ${each.value.environment.name} environment"
}

resource "keycloak_role" "environment_service_team_reader_in_environment_realms" {
  for_each = local.environments_services_teams_merged_map

  realm_id    = keycloak_realm.environments[each.value.environment.name].id
  client_id   = keycloak_openid_client.services_in_environment_realms["${each.value.environment.name}-${each.value.service.name}"].id
  name        = "${var.organisation_name}-${each.value.team.name}-reader"
  description = "Reader of the ${each.value.service.name} service within the ${each.value.team.name} team of the ${var.organisation_name} organisation in the ${each.value.environment.name} environment"
}
