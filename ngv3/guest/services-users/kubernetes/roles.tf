data "keycloak_role" "this" {
  for_each = local.roles_map

  realm_id  = data.keycloak_realm.users.id
  client_id = data.keycloak_openid_client.shared.id
  name      = "kubernetes-${each.value.environment}-${each.value.name}"
}

resource "keycloak_user_roles" "this" {
  for_each = local.users_map

  realm_id = data.keycloak_realm.users.id
  user_id  = data.keycloak_user.this[each.value.username].id

  role_ids = [
    for role in each.value.roles : data.keycloak_role.this["${role.environment}-${role.name}"].id
  ]
}
