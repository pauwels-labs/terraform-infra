// Roles created for team
resource "keycloak_role" "reader" {
  for_each = local.roles_map

  realm_id    = data.keycloak_realm.shared.id
  client_id   = data.keycloak_openid_client.this[each.value.cluster_name].id
  name        = "${var.guest_organisation_name}-${each.value.environment_name}-${var.team_name}-reader"
  description = "Reader of ${var.guest_organisation_name}/${var.team_name} team namespaces in the ${each.value.environment_name} environment Kubernetes clusters"
}

resource "keycloak_role" "writer" {
  for_each = local.roles_map

  realm_id    = data.keycloak_realm.shared.id
  client_id   = data.keycloak_openid_client.this[each.value.cluster_name].id
  name        = "${var.guest_organisation_name}-${each.value.environment_name}-${var.team_name}-writer"
  description = "Writer of ${var.guest_organisation_name}/${var.team_name} team namespaces in the ${each.value.environment_name} environment Kubernetes clusters"
}

resource "keycloak_role" "admin" {
  for_each = local.roles_map

  realm_id    = data.keycloak_realm.shared.id
  client_id   = data.keycloak_openid_client.this[each.value.cluster_name].id
  name        = "${var.guest_organisation_name}-${each.value.environment_name}-${var.team_name}-admin"
  description = "Admin of ${var.guest_organisation_name}/${var.team_name} team namespaces in the ${each.value.environment_name} environment Kubernetes clusters"
}
