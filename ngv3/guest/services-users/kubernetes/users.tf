data "keycloak_user" "this" {
  for_each = local.users_map

  realm_id = data.keycloak_realm.users.id
  username = each.value.username
}
