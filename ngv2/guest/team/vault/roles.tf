resource "keycloak_role" "teamspecific_allenvironments_admin" {
  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared_infra_in_users_realm.id
  name        = "vault-${var.team_name}-allenvironments-admin"
  description = "Administrator of the vault service for the ${var.team_name} team in all environments has full CRUD abilities from the root of the team's location in vault"
}

resource "keycloak_role" "teamspecific_allenvironments_writer" {
  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared_infra_in_users_realm.id
  name        = "vault-${var.team_name}-allenvironments-writer"
  description = "Writer of the vault service for the ${var.team_name} team in all environments has read and update capabilities from the root of the team's location in vault"
}

resource "keycloak_role" "teamspecific_allenvironments_reader" {
  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared_infra_in_users_realm.id
  name        = "vault-${var.team_name}-allenvironments-reader"
  description = "Reader of the vault service for the ${var.team_name} team in all environments has read capabilities from the root of the team's location in vault"
}

resource "keycloak_role" "teamspecific_environmentspecific_admin" {
  for_each = local.environments_map

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared_infra_in_users_realm.id
  name        = "vault-${var.team_name}-${each.value.name}-admin"
  description = "Administrator of the vault service for the ${var.team_name} team in the ${each.value.name} environment has full CRUD abilities from the root of that environment's location in the team's service config location"
}

resource "keycloak_role" "teamspecific_environmentspecific_writer" {
  for_each = local.environments_map

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared_infra_in_users_realm.id
  name        = "vault-${var.team_name}-${each.value.name}-writer"
  description = "Writer of the vault service for the ${var.team_name} team in the ${each.value.name} environment has read and update capabilities from the root of that environment's location in the team's service config location"
}

resource "keycloak_role" "teamspecific_environmentspecific_reader" {
  for_each = local.environments_map

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared_infra_in_users_realm.id
  name        = "vault-${var.team_name}-${each.value.name}-reader"
  description = "Reader of the vault service for the ${var.team_name} team in the ${each.value.name} environment has read capabilities from the root of that environment's location in the team's service config location"
}
