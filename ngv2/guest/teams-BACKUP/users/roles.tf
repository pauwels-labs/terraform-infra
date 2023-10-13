data "keycloak_role" "vault_allteams_allenvironments_admin" {
  realm_id  = data.keycloak_realm.users.id
  client_id = data.keycloak_openid_client.shared_infra_in_users_realm.id
  name      = "vault-allteams-allenvironments-admin"
}
