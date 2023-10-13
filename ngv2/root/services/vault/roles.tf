resource "keycloak_role" "org_allteams_allenvironments_admin" {
  realm_id    = data.keycloak_realm.shared_infra.id
  client_id   = local.vault_client.id
  name        = "${var.organisation_name}-allteams-allenvironments-admin"
  description = "Administrator of all teams across all environments has full CRUD abilities from the root of the organisation's secret backend"
}

resource "keycloak_role" "org_allteams_allenvironments_writer" {
  realm_id    = data.keycloak_realm.shared_infra.id
  client_id   = local.vault_client.id
  name        = "${var.organisation_name}-allteams-allenvironments-writer"
  description = "Writer of all teams across all environments has read and update capabilities from the root of the organisation's secret backend"
}

resource "keycloak_role" "org_allteams_allenvironments_reader" {
  realm_id    = data.keycloak_realm.shared_infra.id
  client_id   = local.vault_client.id
  name        = "${var.organisation_name}-allteams-allenvironments-reader"
  description = "Reader of all teams across all environments has read capabilities from the root of the organisation's secret backend"
}

resource "keycloak_role" "org_allteams_environmentspecific_admin" {
  for_each = local.environments_map

  realm_id    = data.keycloak_realm.shared_infra.id
  client_id   = local.vault_client.id
  name        = "${var.organisation_name}-allteams-${each.value.name}-admin"
  description = "Administrator of all teams in the ${each.value.name} environment has full CRUD abilities for the service config in ${each.value.name}"
}

resource "keycloak_role" "org_allteams_environmentspecific_writer" {
  for_each = local.environments_map

  realm_id    = data.keycloak_realm.shared_infra.id
  client_id   = local.vault_client.id
  name        = "${var.organisation_name}-allteams-${each.value.name}-writer"
  description = "Writer of all teams in the ${each.value.name} environment has read and update abilities for the service config in ${each.value.name}"
}

resource "keycloak_role" "org_allteams_environmentspecific_reader" {
  for_each = local.environments_map

  realm_id    = data.keycloak_realm.shared_infra.id
  client_id   = local.vault_client.id
  name        = "${var.organisation_name}-allteams-${each.value.name}-reader"
  description = "Reader of all teams in the ${each.value.name} environment has read abilities for the service config in ${each.value.name}"
}

resource "keycloak_role" "org_teamspecific_allenvironments_admin" {
  for_each = local.teams_map

  realm_id    = data.keycloak_realm.shared_infra.id
  client_id   = local.vault_client.id
  name        = "${var.organisation_name}-${each.value.name}-allenvironments-admin"
  description = "Administrator of the ${each.value.name} team in all environments has full CRUD abilities from the root of the team's location in vault"
}

resource "keycloak_role" "org_teamspecific_allenvironments_writer" {
  for_each = local.teams_map

  realm_id    = data.keycloak_realm.shared_infra.id
  client_id   = local.vault_client.id
  name        = "${var.organisation_name}-${each.value.name}-allenvironments-writer"
  description = "Writer of the ${each.value.name} team in all environments has read and update abilities from the root of the team's location in vault"
}

resource "keycloak_role" "org_teamspecific_allenvironments_reader" {
  for_each = local.teams_map

  realm_id    = data.keycloak_realm.shared_infra.id
  client_id   = local.vault_client.id
  name        = "${var.organisation_name}-${each.value.name}-allenvironments-reader"
  description = "Reader of the ${each.value.name} team in all environments has read abilities from the root of the team's location in vault"
}

resource "keycloak_role" "org_teamspecific_environmentspecific_admin" {
  for_each = local.teams_environments_merged_map

  realm_id    = data.keycloak_realm.shared_infra.id
  client_id   = local.vault_client.id
  name        = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-admin"
  description = "Administrator of the ${each.value.team.name} team in the ${each.value.environment.name} environment has full CRUD abilities from the root of that environment's location in the team's service config location"
}

resource "keycloak_role" "org_teamspecific_environmentspecific_writer" {
  for_each = local.teams_environments_merged_map

  realm_id    = data.keycloak_realm.shared_infra.id
  client_id   = local.vault_client.id
  name        = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-writer"
  description = "Administrator of the ${each.value.team.name} team in the ${each.value.environment.name} environment has read and update abilities from the root of that environment's location in the team's service config location"
}

resource "keycloak_role" "org_teamspecific_environmentspecific_reader" {
  for_each = local.teams_environments_merged_map

  realm_id    = data.keycloak_realm.shared_infra.id
  client_id   = local.vault_client.id
  name        = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-reader"
  description = "Reader of the ${each.value.team.name} team in the ${each.value.environment.name} environment has read abilities from the root of that environment's location in the team's service config location"
}
