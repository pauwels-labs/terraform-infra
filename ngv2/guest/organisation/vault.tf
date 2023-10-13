module "vault" {
  source = "./vault"

  organisation_name      = var.organisation_name
  root_organisation_name = var.root_organisation_name
  environments           = var.environments
}
