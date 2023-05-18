resource "keycloak_realm" "pauwels_labs_main" {
  realm                       = "pauwels-labs-main"
  enabled                     = true
  display_name                = "pauwels-labs-main"
  default_signature_algorithm = "RS256"
  display_name_html           = "pauwels-labs-main"
}
