// Roles created for team
resource "keycloak_role" "reader" {
  for_each = local.created_role_environments_mapped

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared.id
  name        = "kubernetes-${each.value.name}-${var.team_name}-reader"
  description = "Reader of ${var.organisation_name}/${var.team_name} team namespaces in the Kubernetes clusters in the ${each.value.name} environment"
}

resource "keycloak_role" "writer" {
  for_each = local.created_role_environments_mapped

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared.id
  name        = "kubernetes-${each.value.name}-${var.team_name}-writer"
  description = "Writer of ${var.organisation_name}/${var.team_name} team namespaces in the Kubernetes clusters in the ${each.value.name} environment"
}

resource "keycloak_role" "admin" {
  for_each = local.created_role_environments_mapped

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared.id
  name        = "kubernetes-${each.value.name}-${var.team_name}-admin"
  description = "Admin of ${var.organisation_name}/${var.team_name} team namespaces in the Kubernetes clusters in the ${each.value.name} environment"
}

// Roles imported for team
data "keycloak_role" "root" {
  for_each = local.root_roles_map

  realm_id  = data.keycloak_realm.users.id
  client_id = data.keycloak_openid_client.shared.id
  name      = each.key
}

data "keycloak_role" "allteams" {
  for_each = local.allteams_roles_map

  realm_id  = data.keycloak_realm.users.id
  client_id = data.keycloak_openid_client.shared.id
  name      = each.key
}

data "keycloak_role" "teams" {
  for_each = local.teams_roles_map

  realm_id  = data.keycloak_realm.users.id
  client_id = data.keycloak_openid_client.shared.id
  name      = each.key

  depends_on = [
    keycloak_role.reader,
    keycloak_role.writer,
    keycloak_role.admin
  ]
}
