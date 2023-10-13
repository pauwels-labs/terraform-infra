locals {
  idp_url = trim(var.idp_url, "/")

  organisation_display_name = var.organisation_display_name != null ? var.organisation_display_name : var.organisation_name
  environments_map          = { for environment in var.environments : environment.name => environment }

  realm_shared_infra        = var.is_root ? keycloak_realm.shared_infra : data.keycloak_realm.shared_infra
  realm_environment_infras  = var.is_root ? keycloak_realm.environment_infras : data.keycloak_realm.environment_infras
}
