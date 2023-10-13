resource "keycloak_attribute_to_role_identity_provider_mapper" "org_allteams_allenvironments_admin" {
  realm                   = data.keycloak_realm.shared_infra.id
  name                    = "vault-allteams-allenvironments-admin"
  identity_provider_alias = var.organisation_name
  role                    = "vault.${var.organisation_name}-allteams-allenvironments-admin"
  claim_name              = "roles"
  claim_value             = "vault-allteams-allenvironments-admin"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "org_allteams_allenvironments_writer" {
  realm                   = data.keycloak_realm.shared_infra.id
  name                    = "vault-allteams-allenvironments-writer"
  identity_provider_alias = var.organisation_name
  role                    = "vault.${var.organisation_name}-allteams-allenvironments-writer"
  claim_name              = "roles"
  claim_value             = "vault-allteams-allenvironments-writer"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "org_allteams_allenvironments_reader" {
  realm                   = data.keycloak_realm.shared_infra.id
  name                    = "vault-allteams-allenvironments-reader"
  identity_provider_alias = var.organisation_name
  role                    = "vault.${var.organisation_name}-allteams-allenvironments-reader"
  claim_name              = "roles"
  claim_value             = "vault-allteams-allenvironments-reader"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "org_allteams_environmentspecific_admin" {
  for_each = local.environments_map

  realm                   = data.keycloak_realm.shared_infra.id
  name                    = "vault-allteams-${each.value.name}-admin"
  identity_provider_alias = var.organisation_name
  role                    = "vault.${var.organisation_name}-allteams-${each.value.name}-admin"
  claim_name              = "roles"
  claim_value             = "vault-allteams-${each.value.name}-admin"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "org_allteams_environmentspecific_writer" {
  for_each = local.environments_map

  realm                   = data.keycloak_realm.shared_infra.id
  name                    = "vault-allteams-${each.value.name}-writer"
  identity_provider_alias = var.organisation_name
  role                    = "vault.${var.organisation_name}-allteams-${each.value.name}-writer"
  claim_name              = "roles"
  claim_value             = "vault-allteams-${each.value.name}-writer"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "org_allteams_environmentspecific_reader" {
  for_each = local.environments_map

  realm                   = data.keycloak_realm.shared_infra.id
  name                    = "vault-allteams-${each.value.name}-reader"
  identity_provider_alias = var.organisation_name
  role                    = "vault.${var.organisation_name}-allteams-${each.value.name}-reader"
  claim_name              = "roles"
  claim_value             = "vault-allteams-${each.value.name}-reader"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "org_teamspecific_allenvironments_admin" {
  for_each = local.teams_map

  realm                   = data.keycloak_realm.shared_infra.id
  name                    = "vault-${each.value.name}-allenvironments-admin"
  identity_provider_alias = var.organisation_name
  role                    = "vault.${var.organisation_name}-${each.value.name}-allenvironments-admin"
  claim_name              = "roles"
  claim_value             = "vault-${each.value.name}-allenvironments-admin"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "org_teamspecific_allenvironments_writer" {
  for_each = local.teams_map

  realm                   = data.keycloak_realm.shared_infra.id
  name                    = "vault-${each.value.name}-allenvironments-writer"
  identity_provider_alias = var.organisation_name
  role                    = "vault.${var.organisation_name}-${each.value.name}-allenvironments-writer"
  claim_name              = "roles"
  claim_value             = "vault-${each.value.name}-allenvironments-writer"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "org_teamspecific_allenvironments_reader" {
  for_each = local.teams_map

  realm                   = data.keycloak_realm.shared_infra.id
  name                    = "vault-${each.value.name}-allenvironments-reader"
  identity_provider_alias = var.organisation_name
  role                    = "vault.${var.organisation_name}-${each.value.name}-allenvironments-reader"
  claim_name              = "roles"
  claim_value             = "vault-${each.value.name}-allenvironments-reader"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "org_teamspecific_environmentspecific_admin" {
  for_each = local.teams_environments_merged_map

  realm                   = data.keycloak_realm.shared_infra.id
  name                    = "vault-${each.value.team.name}-${each.value.environment.name}-admin"
  identity_provider_alias = var.organisation_name
  role                    = "vault.${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-admin"
  claim_name              = "roles"
  claim_value             = "vault-${each.value.team.name}-${each.value.environment.name}-admin"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "org_teamspecific_environmentspecific_writer" {
  for_each = local.teams_environments_merged_map

  realm                   = data.keycloak_realm.shared_infra.id
  name                    = "vault-${each.value.team.name}-${each.value.environment.name}-writer"
  identity_provider_alias = var.organisation_name
  role                    = "vault.${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-writer"
  claim_name              = "roles"
  claim_value             = "vault-${each.value.team.name}-${each.value.environment.name}-writer"
  extra_config            = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "org_teamspecific_environmentspecific_reader" {
  for_each = local.teams_environments_merged_map

  realm                   = data.keycloak_realm.shared_infra.id
  name                    = "vault-${each.value.team.name}-${each.value.environment.name}-reader"
  identity_provider_alias = var.organisation_name
  role                    = "vault.${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-reader"
  claim_name              = "roles"
  claim_value             = "vault-${each.value.team.name}-${each.value.environment.name}-reader"
  extra_config            = {
    syncMode = "FORCE"
  }
}
