resource "keycloak_openid_user_client_role_protocol_mapper" "shared_infra_in_users_realm" {
  count = local.link_to_root_organisation ? 1 : 0

  realm_id                    = data.keycloak_realm.users.id
  name                        = "client-roles"
  claim_name                  = "roles"
  client_id                   = keycloak_openid_client.shared_infra_in_users_realm[0].id
  claim_value_type            = "String"
  multivalued                 = true
  add_to_id_token             = true
  add_to_access_token         = true
  add_to_userinfo             = true
}

# resource "keycloak_openid_user_client_role_protocol_mapper" "services_in_environment_realms" {
#   for_each = local.environments_services_merged_map

#   realm_id                    = keycloak_realm.environments[each.value.environment.name].id
#   name                        = "client-roles"
#   claim_name                  = "roles"
#   client_id                   = keycloak_openid_client.services_in_environment_realms[each.key].id
#   claim_value_type            = "String"
#   multivalued                 = true
#   add_to_id_token             = true
#   add_to_access_token         = true
#   add_to_userinfo             = true
# }

# resource "keycloak_openid_user_realm_role_protocol_mapper" "services_in_environment_realms" {
#   for_each = local.environments_services_merged_map

#   realm_id                    = keycloak_realm.environments[each.value.environment.name].id
#   name                        = "realm-roles"
#   claim_name                  = "roles"
#   client_id                   = keycloak_openid_client.services_in_environment_realms[each.key].id
#   claim_value_type            = "String"
#   multivalued                 = true
#   add_to_id_token             = true
#   add_to_access_token         = true
#   add_to_userinfo             = true
# }

# resource "keycloak_generic_role_mapper" "root_role_mapper_for_services_in_environment_realms" {
#   for_each = var.is_root ? local.environments_services_merged_map : {}

#   realm_id  = keycloak_realm.environments[each.value.environment.name].id
#   client_id = keycloak_openid_client.services_in_environment_realms[each.key].id
#   role_id   = keycloak_role.environment_root_in_environment_realms[each.value.environment.name].id
# }
