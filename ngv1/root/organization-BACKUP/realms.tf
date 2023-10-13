resource "keycloak_realm" "infra" {
  realm                       = "${var.organisation_name}-infra"
  enabled                     = true
  display_name                = "${local.organisation_display_name} INFRASTRUCTURE"
  default_signature_algorithm = "RS256"
}

# resource "keycloak_realm" "environments" {
#   for_each = local.environments_map

#   realm                       = "${var.organisation_name}-${each.key}"
#   enabled                     = true
#   display_name                = "${local.organisation_display_name} ${upper(each.key)}"
#   default_signature_algorithm = "RS256"
# }
