data "keycloak_openid_client" "guest_shared_infra_in_users_realm" {
  realm_id  = data.keycloak_realm.guest_users.id
  client_id = data.keycloak_realm.root_shared_infra.realm
}

data "keycloak_openid_client" "guest_environment_infras_in_users_realm" {
  for_each = local.environments_map

  realm_id  = data.keycloak_realm.guest_users.id
  client_id = data.keycloak_realm.root_environment_infras[each.key].realm
}
