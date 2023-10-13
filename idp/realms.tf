resource "keycloak_realm" "users" {
  realm                       = "${var.organisation_name}-users"
  enabled                     = true
  display_name                = local.organisation_display_name
  default_signature_algorithm = "RS256"
}

resource "keycloak_realm" "environments" {
  for_each = local.environments_map

  realm                       = "${var.organisation_name}-${each.key}"
  enabled                     = true
  display_name                = "${local.organisation_display_name} ${upper(each.key)}"
  default_signature_algorithm = "RS256"
}
