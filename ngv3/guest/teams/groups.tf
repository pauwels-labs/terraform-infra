resource "keycloak_group" "this" {
  for_each = local.teams_map

  realm_id = data.keycloak_realm.users.id
  name     = each.value.name
}

resource "keycloak_group" "subteams" {
  for_each = local.subteams_map

  realm_id  = data.keycloak_realm.users.id
  parent_id = keycloak_group.this[each.value.team_name].id
  name      = "${each.value.team_name}-${each.value.subteam_name}"
}
