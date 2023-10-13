// All services/All teams
resource "keycloak_role" "environment_allservices_allteams_admin_in_user_realm" {
  for_each = local.environments_map

  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.environments[each.value.name].id
  name      = "allservices-allteams-admin"
  description = "Administrator of all services within all teams in the ${each.value.name} environment"
  composite_roles = [
    for key, role in keycloak_role.environment_service_team_admin_in_user_realm : role.id if length(regexall("^${each.value.name}-\\w+-\\w+$", key)) > 0
  ]
}

resource "keycloak_role" "environment_allservices_allteams_writer_in_user_realm" {
  for_each = local.environments_map

  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.environments[each.value.name].id
  name      = "allservices-allteams-writer"
  description = "Writer of all services within all teams in the ${each.value.name} environment"
  composite_roles = [
    for key, role in keycloak_role.environment_service_team_writer_in_user_realm : role.id if length(regexall("^${each.value.name}-\\w+-\\w+$", key)) > 0
  ]
}

resource "keycloak_role" "environment_allservices_allteams_reader_in_user_realm" {
  for_each = local.environments_map

  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.environments[each.value.name].id
  name      = "allservices-allteams-reader"
  description = "Reader of all services within all teams in the ${each.value.name} environment"
  composite_roles = [
    for key, role in keycloak_role.environment_service_team_reader_in_user_realm : role.id if length(regexall("^${each.value.name}-\\w+-\\w+$", key)) > 0
  ]
}

// All services/Specific team
resource "keycloak_role" "environment_allservices_team_admin_in_user_realm" {
  for_each = local.environments_teams_merged_map

  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.environments[each.value.environment.name].id
  name      = "allservices-${each.value.team.name}-admin"
  description = "Administrator of all services within the ${each.value.team.name} team in the ${each.value.environment.name} environment"
  composite_roles = [
    for key, role in keycloak_role.environment_service_team_admin_in_user_realm : role.id if length(regexall("^${each.value.environment.name}-\\w+-${each.value.team.name}$", key)) > 0
  ]
}

resource "keycloak_role" "environment_allservices_team_writer_in_user_realm" {
  for_each = local.environments_teams_merged_map

  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.environments[each.value.environment.name].id
  name      = "allservices-${each.value.team.name}-writer"
  description = "Writer of all services within the ${each.value.team.name} team in the ${each.value.environment.name} environment"
  composite_roles = [
    for key, role in keycloak_role.environment_service_team_writer_in_user_realm : role.id if length(regexall("^${each.value.environment.name}-\\w+-${each.value.team.name}$", key)) > 0
  ]
}

resource "keycloak_role" "environment_allservices_team_reader_in_user_realm" {
  for_each = local.environments_teams_merged_map

  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.environments[each.value.environment.name].id
  name      = "allservices-${each.value.team.name}-reader"
  description = "Reader of all services within the ${each.value.team.name} team in the ${each.value.environment.name} environment"
  composite_roles = [
    for key, role in keycloak_role.environment_service_team_reader_in_user_realm : role.id if length(regexall("^${each.value.environment.name}-\\w+-${each.value.team.name}$", key)) > 0
  ]
}

// Specific service/All teams
resource "keycloak_role" "environment_service_allteams_admin_in_user_realm" {
  for_each = local.environments_services_merged_map

  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.environments[each.value.environment.name].id
  name      = "${each.value.service.name}-allteams-admin"
  description = "Administrator of the ${each.value.service.name} service within all teams in the ${each.value.environment.name} environment"
  composite_roles = [
    for key, role in keycloak_role.environment_service_team_admin_in_user_realm : role.id if length(regexall("^${each.value.environment.name}-${each.value.service.name}-\\w+$", key)) > 0
  ]
}

resource "keycloak_role" "environment_service_allteams_writer_in_user_realm" {
  for_each = local.environments_services_merged_map

  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.environments[each.value.environment.name].id
  name      = "${each.value.service.name}-allteams-writer"
  description = "Writer of the ${each.value.service.name} service within all teams in the ${each.value.environment.name} environment"
  composite_roles = [
    for key, role in keycloak_role.environment_service_team_writer_in_user_realm : role.id if length(regexall("^${each.value.environment.name}-${each.value.service.name}-\\w+$", key)) > 0
  ]
}

resource "keycloak_role" "environment_service_allteams_reader_in_user_realm" {
  for_each = local.environments_services_merged_map

  realm_id  = keycloak_realm.users.id
  client_id = keycloak_openid_client.environments[each.value.environment.name].id
  name      = "${each.value.service.name}-allteams-reader"
  description = "Reader of the ${each.value.service.name} service within all teams in the ${each.value.environment.name} environment"
  composite_roles = [
    for key, role in keycloak_role.environment_service_team_reader_in_user_realm : role.id if length(regexall("^${each.value.environment.name}-${each.value.service.name}-\\w+$", key)) > 0
  ]
}
