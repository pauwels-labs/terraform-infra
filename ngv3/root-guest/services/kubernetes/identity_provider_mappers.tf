resource "keycloak_attribute_to_role_identity_provider_mapper" "superadmin" {
  for_each = var.is_root ? var.cluster_names : []

  realm                   = data.keycloak_realm.shared.id
  name                    = "kubernetes-${each.key}-${var.environment_name}-superadmin"
  identity_provider_alias = var.guest_organisation_name
  role                    = "kubernetes-${each.key}.superadmin"
  claim_name              = "roles"
  claim_value             = "kubernetes-${var.environment_name}-superadmin"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "superwriter" {
  for_each = var.is_root ? var.cluster_names : []

  realm                   = data.keycloak_realm.shared.id
  name                    = "kubernetes-${each.key}-${var.environment_name}-superwriter"
  identity_provider_alias = var.guest_organisation_name
  role                    = "kubernetes-${each.key}.superwriter"
  claim_name              = "roles"
  claim_value             = "kubernetes-${var.environment_name}-superwriter"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "superreader" {
  for_each = var.is_root ? var.cluster_names : []

  realm                   = data.keycloak_realm.shared.id
  name                    = "kubernetes-${each.key}-${var.environment_name}-superreader"
  identity_provider_alias = var.guest_organisation_name
  role                    = "kubernetes-${each.key}.superreader"
  claim_name              = "roles"
  claim_value             = "kubernetes-${var.environment_name}-superreader"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "infraadmin" {
  for_each = var.is_root ? var.cluster_names : []

  realm                   = data.keycloak_realm.shared.id
  name                    = "kubernetes-${each.key}-${var.environment_name}-infraadmin"
  identity_provider_alias = var.guest_organisation_name
  role                    = "kubernetes-${each.key}.infraadmin"
  claim_name              = "roles"
  claim_value             = "kubernetes-${var.environment_name}-infraadmin"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "infrawriter" {
  for_each = var.is_root ? var.cluster_names : []

  realm                   = data.keycloak_realm.shared.id
  name                    = "kubernetes-${each.key}-${var.environment_name}-infrawriter"
  identity_provider_alias = var.guest_organisation_name
  role                    = "kubernetes-${each.key}.infrawriter"
  claim_name              = "roles"
  claim_value             = "kubernetes-${var.environment_name}-infrawriter"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "infrareader" {
  for_each = var.is_root ? var.cluster_names : []

  realm                   = data.keycloak_realm.shared.id
  name                    = "kubernetes-${each.key}-${var.environment_name}-infrareader"
  identity_provider_alias = var.guest_organisation_name
  role                    = "kubernetes-${each.key}.infrareader"
  claim_name              = "roles"
  claim_value             = "kubernetes-${var.environment_name}-infrareader"
  extra_config            = {
    syncMode = "FORCE"
  }
}
