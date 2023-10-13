resource "keycloak_realm" "users" {
  realm                       = "${var.organisation_name}-users"
  enabled                     = true
  display_name                = local.organisation_display_name
  default_signature_algorithm = "RS256"
}
