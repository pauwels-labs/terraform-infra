resource "keycloak_openid_user_client_role_protocol_mapper" "shared_in_users_realm" {
  realm_id                    = keycloak_realm.users.id
  name                        = "client-roles"
  claim_name                  = "roles"
  client_id                   = keycloak_openid_client.shared_in_users_realm.id
  client_id_for_role_mappings = keycloak_openid_client.shared_in_users_realm.client_id
  claim_value_type            = "String"
  multivalued                 = true
  add_to_id_token             = true
  add_to_access_token         = true
  add_to_userinfo             = true
}
