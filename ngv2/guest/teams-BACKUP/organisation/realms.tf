data "keycloak_realm" "environments" {
  for_each = local.environments_map

  realm = "${var.organisation_name}-${each.value.name}"
}

data "keycloak_realm" "users" {
  realm = "${var.organisation_name}-users"
}
