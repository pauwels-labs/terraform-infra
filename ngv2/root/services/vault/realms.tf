data "keycloak_realm" "shared_infra" {
  realm = "${var.is_root ? var.organisation_name : var.root_organisation_name}-shared-infra"
}
