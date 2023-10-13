# resource "keycloak_group" "root_in_user_realm" {
#   realm_id = keycloak_realm.users.id
#   name     = "root"
# }

# resource "keycloak_group_roles" "root_in_user_realm" {
#   for_each = local.environments_map

#   realm_id = keycloak_realm.users.id
#   group_id = keycloak_group.root_in_user_realm.id
#   role_ids = [
#     for role in keycloak_role.environment_root_in_user_realm : role.id
#   ]
# }
