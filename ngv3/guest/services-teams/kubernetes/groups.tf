data "keycloak_group" "this" {
  realm_id = data.keycloak_realm.users.id
  name     = var.team_name
}

resource "keycloak_group_roles" "this_root_roles" {
  count = local.team_assignments != null ? 1 : 0

  realm_id   = data.keycloak_realm.users.id
  group_id   = data.keycloak_group.this.id
  exhaustive = false

  role_ids = [
    for role in local.team_assignments.roles : data.keycloak_role.root["kubernetes-${role.environment}-${role.name}"].id if role.is_root
  ]
}

resource "keycloak_group_roles" "this_allteams_roles" {
  count = local.team_assignments != null ? 1 : 0

  realm_id   = data.keycloak_realm.users.id
  group_id   = data.keycloak_group.this.id
  exhaustive = false

  role_ids = [
    for role in local.team_assignments.roles : data.keycloak_role.allteams["kubernetes-${role.environment}-allteams-${role.name}"].id if role.is_allteams
  ]
}

resource "keycloak_group_roles" "this_teams_roles" {
  count = local.team_assignments != null ? 1 : 0

  realm_id   = data.keycloak_realm.users.id
  group_id   = data.keycloak_group.this.id
  exhaustive = false

  role_ids = [
    for role in local.team_assignments.roles : data.keycloak_role.teams["kubernetes-${role.environment}-${role.team_name != null ? role.team_name : var.team_name}-${role.name}"].id if !role.is_root && !role.is_allteams
  ]
}

data "keycloak_group" "subteams" {
  for_each = local.subteams_assignments_map

  realm_id = data.keycloak_realm.users.id
  name = "${var.team_name}-${each.value.subteam_name}"
}

resource "keycloak_group_roles" "subteams_root_roles" {
  for_each = local.subteams_assignments_map

  realm_id   = data.keycloak_realm.users.id
  group_id   = data.keycloak_group.subteams[each.key].id
  exhaustive = false

  role_ids = [
    for role in each.value.roles : data.keycloak_role.root["kubernetes-${role.environment}-${role.name}"].id if role.is_root
  ]
}

resource "keycloak_group_roles" "subteams_allteams_roles" {
  for_each = local.subteams_assignments_map

  realm_id   = data.keycloak_realm.users.id
  group_id   = data.keycloak_group.subteams[each.key].id
  exhaustive = false

  role_ids = [
    for role in each.value.roles : data.keycloak_role.allteams["kubernetes-${role.environment}-allteams-${role.name}"].id if role.is_allteams
  ]
}

resource "keycloak_group_roles" "subteams_teams_roles" {
  for_each = local.subteams_assignments_map

  realm_id   = data.keycloak_realm.users.id
  group_id   = data.keycloak_group.subteams[each.key].id
  exhaustive = false

  role_ids = [
    for role in each.value.roles : data.keycloak_role.teams["kubernetes-${role.environment}-${role.team_name != null ? role.team_name : var.team_name}-${role.name}"].id if !role.is_root && !role.is_allteams
  ]
}
