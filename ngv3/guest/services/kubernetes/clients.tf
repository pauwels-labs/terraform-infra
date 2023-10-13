data "keycloak_openid_client" "shared" {
  realm_id  = data.keycloak_realm.users.id
  client_id = var.root_shared_realm_client_id
}
