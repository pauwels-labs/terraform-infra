data "keycloak_realm" "shared" {
  realm = "${var.root_organisation_name}-shared"
}
