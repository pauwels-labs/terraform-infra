data "keycloak_openid_client" "shared_infra_in_users_realm" {
  realm_id  = data.keycloak_realm.users.id
  client_id = "${var.root_organisation_name}-shared-infra"
}
