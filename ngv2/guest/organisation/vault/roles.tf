resource "keycloak_role" "allteams_allenvironments_admin" {
  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared_infra_in_users_realm.id
  name        = "vault-allteams-allenvironments-admin"
  description = "Administrator of the vault service across all teams and environments has full CRUD abilities from the root of the organisation's secret backend"
}

resource "keycloak_role" "allteams_allenvironments_writer" {
  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared_infra_in_users_realm.id
  name        = "vault-allteams-allenvironments-writer"
  description = "Writer of the vault service across all teams and environments has read and update capabilities from the root of the organisation's secret backend"
}

resource "keycloak_role" "allteams_allenvironments_reader" {
  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared_infra_in_users_realm.id
  name        = "vault-allteams-allenvironments-reader"
  description = "Reader of the vault service across all teams and environments has read capabilities from the root of the organisation's secret backend"
}

resource "keycloak_role" "allteams_environmentspecific_admin" {
  for_each = local.environments_map

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared_infra_in_users_realm.id
  name        = "vault-allteams-${each.value.name}-admin"
  description = "Administrator of the vault service across all teams in the ${each.value.name} environment has full CRUD abilities from the root of the organisation's secret backend"
}

resource "keycloak_role" "allteams_environmentspecific_writer" {
  for_each = local.environments_map

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared_infra_in_users_realm.id
  name        = "vault-allteams-${each.value.name}-writer"
  description = "Writer of the vault service across all teams in the ${each.value.name} environment has read and update capabilities from the root of the organisation's secret backend"
}

resource "keycloak_role" "allteams_environmentspecific_reader" {
  for_each = local.environments_map

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared_infra_in_users_realm.id
  name        = "vault-allteams-${each.value.name}-reader"
  description = "Reader of the vault service across all teams in the ${each.value.name} environment has read capabilities from the root of the organisation's secret backend"
}
