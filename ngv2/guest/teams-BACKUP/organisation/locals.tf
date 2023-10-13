locals {
  idp_url   = trim(var.idp_url, "/")
  vault_url = trim(var.vault_url, "/")

  environments_map          = { for environment in var.environments : environment.name => environment }
  link_to_root_organisation = var.root_organisation_name != null
}
