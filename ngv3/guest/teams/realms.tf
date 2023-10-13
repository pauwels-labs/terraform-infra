data "keycloak_realm" "users" {
  realm = "${var.organisation_name}-users"
}
