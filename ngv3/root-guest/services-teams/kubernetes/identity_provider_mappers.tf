resource "keycloak_attribute_to_role_identity_provider_mapper" "admin" {
  for_each = local.roles_map

  realm                   = data.keycloak_realm.shared.id
  name                    = "kubernetes-${each.value.cluster_name}-${each.value.environment_name}-${var.team_name}-admin"
  identity_provider_alias = var.guest_organisation_name
  role                    = "kubernetes-${each.value.cluster_name}.${var.guest_organisation_name}-${each.value.environment_name}-${var.team_name}-admin"
  claim_name              = "roles"
  claim_value             = "kubernetes-${each.value.environment_name}-${var.team_name}-admin"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "writer" {
  for_each = local.roles_map

  realm                   = data.keycloak_realm.shared.id
  name                    = "kubernetes-${each.value.cluster_name}-${each.value.environment_name}-${var.team_name}-writer"
  identity_provider_alias = var.guest_organisation_name
  role                    = "kubernetes-${each.value.cluster_name}.${var.guest_organisation_name}-${each.value.environment_name}-${var.team_name}-writer"
  claim_name              = "roles"
  claim_value             = "kubernetes-${each.value.environment_name}-${var.team_name}-writer"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "reader" {
  for_each = local.roles_map

  realm                   = data.keycloak_realm.shared.id
  name                    = "kubernetes-${each.value.cluster_name}-${each.value.environment_name}-${var.team_name}-reader"
  identity_provider_alias = var.guest_organisation_name
  role                    = "kubernetes-${each.value.cluster_name}.${var.guest_organisation_name}-${each.value.environment_name}-${var.team_name}-reader"
  claim_name              = "roles"
  claim_value             = "kubernetes-${each.value.environment_name}-${var.team_name}-reader"
  extra_config            = {
    syncMode = "FORCE"
  }
}
