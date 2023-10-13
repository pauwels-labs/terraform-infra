resource "keycloak_realm" "users" {
  realm                       = "${var.organisation_name}-users"
  enabled                     = true
  display_name                = local.organisation_display_name
  default_signature_algorithm = "RS256"
}

resource "keycloak_realm" "environments" {
  for_each = var.is_guest ? local.environments_map : {}

  realm                       = "${var.organisation_name}-${each.key}"
  enabled                     = true
  display_name                = "${local.organisation_display_name} ${upper(each.key)}"
  default_signature_algorithm = "RS256"
}

resource "keycloak_realm" "infra" {
  count = var.is_root ? 1 : 0

  realm                       = "${var.organisation_name}-infra"
  enabled                     = true
  display_name                = "${local.organisation_display_name} INFRA"
  default_signature_algorithm = "RS256"
}

data "keycloak_realm" "infra" {
  count = !var.is_root && var.root_organisation_name != null ? 1 : 0

  realm = "${var.root_organisation_name}-infra"
}
