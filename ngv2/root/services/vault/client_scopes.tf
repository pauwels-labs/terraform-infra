resource "keycloak_openid_user_client_role_protocol_mapper" "vault_in_shared_infra_realm" {
  count = var.is_root ? 1 : 0

  realm_id                    = data.keycloak_realm.shared_infra.id
  name                        = "client-roles"
  claim_name                  = "roles"
  client_id                   = keycloak_openid_client.vault_in_shared_infra_realm[0].id
  claim_value_type            = "String"
  multivalued                 = true
  add_to_id_token             = true
  add_to_access_token         = true
  add_to_userinfo             = true
}
