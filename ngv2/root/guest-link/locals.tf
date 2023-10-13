locals {
  idp_url                   = trim(var.idp_url, "/")
  environments_map          = { for environment in var.environments : environment.name => environment }
}
