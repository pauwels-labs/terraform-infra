resource "keycloak_openid_user_client_role_protocol_mapper" "roles" {
  for_each = var.cluster_names

  realm_id                    = data.keycloak_realm.shared.id
  name                        = "client-roles"
  claim_name                  = "roles"
  client_id                   = keycloak_openid_client.this[each.key].id
  client_id_for_role_mappings = keycloak_openid_client.this[each.key].client_id
  claim_value_type            = "String"
  multivalued                 = true
  add_to_id_token             = true
  add_to_access_token         = true
  add_to_userinfo             = true
}
