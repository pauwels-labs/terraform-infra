// All organisations
resource "keycloak_realm" "users" {
  realm                       = "${var.organisation_name}-users"
  enabled                     = true
  display_name                = local.organisation_display_name
  default_signature_algorithm = "RS256"
}

// Root organisation
resource "keycloak_realm" "shared_infra" {
  count = var.is_root ? 1 : 0

  realm                       = "${var.organisation_name}-shared-infra"
  enabled                     = true
  display_name                = "${local.organisation_display_name} SHARED INFRA"
  default_signature_algorithm = "RS256"
}

data "keycloak_realm" "shared_infra" {
  count = !var.is_root && var.root_organisation_name != null ? 1 : 0

  realm = "${var.root_organisation_name}-shared-infra"
}

resource "keycloak_realm" "environment_infras" {
  for_each = var.is_root ? local.environments_map : {}

  realm                       = "${var.organisation_name}-${each.value.name}-infra"
  enabled                     = true
  display_name                = "${local.organisation_display_name} ${upper(each.value.name)} INFRA"
  default_signature_algorithm = "RS256"
}

data "keycloak_realm" "environment_infras" {
  for_each = !var.is_root && var.root_organisation_name != null ? local.environments_map : {}

  realm = "${var.root_organisation_name}-${each.value.name}-infra"
}

// Guest organisation
resource "keycloak_realm" "environments" {
  for_each = var.is_guest ? local.environments_map : {}

  realm                       = "${var.organisation_name}-${each.value.name}"
  enabled                     = true
  display_name                = "${local.organisation_display_name} ${upper(each.value.name)}"
  default_signature_algorithm = "RS256"
}
