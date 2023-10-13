data "keycloak_realm" "infra" {
  realm = "${var.organisation_name}-infra"
}
