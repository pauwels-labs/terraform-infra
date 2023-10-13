resource "keycloak_realm" "shared" {
  realm                       = "${var.organisation_name}-shared"
  enabled                     = true
  display_name                = local.organisation_display_name
  default_signature_algorithm = "RS256"
}
