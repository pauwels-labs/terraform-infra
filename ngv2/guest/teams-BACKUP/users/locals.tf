locals {
  idp_url = trim(var.idp_url, "/")

  users_map = { for user in var.users : user.username => user }
}
