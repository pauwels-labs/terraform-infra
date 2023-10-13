data "keycloak_group" "teams" {
  for_each = local.teams_map

  realm_id = data.keycloak_realm.users.id
  name     = each.key
}
