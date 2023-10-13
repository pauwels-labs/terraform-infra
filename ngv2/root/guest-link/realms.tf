data "keycloak_realm" "root_shared_infra" {
  realm = "${var.root_organisation_name}-shared-infra"
}

data "keycloak_realm" "root_environment_infras" {
  for_each = local.environments_map

  realm = "${var.root_organisation_name}-${each.value.name}-infra"
}

data "keycloak_realm" "guest_users" {
  realm = "${var.guest_organisation_name}-users"
}
