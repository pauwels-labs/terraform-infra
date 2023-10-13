data "keycloak_realm" "shared" {
  realm = "${var.organisation_name}-shared"
}
