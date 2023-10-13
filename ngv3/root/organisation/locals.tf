locals {
  idp_url = trim(var.idp_url, "/")

  organisation_display_name = var.organisation_display_name != null ? var.organisation_display_name : var.organisation_name
}
