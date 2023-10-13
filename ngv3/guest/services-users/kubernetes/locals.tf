locals {
  idp_url         = trim(var.idp_url, "/")
  users_map       = { for user in var.users : user.username => user }
  roles_unique    = distinct(flatten([
    for user in var.users : [
      for role in user.roles : role
    ]
  ]))
  roles_map       = { for role in local.roles_unique : "${role.environment}-${role.name}" => role }
}
