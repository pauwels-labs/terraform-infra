// Roles inside kubernetes clients in the shared realm
resource "keycloak_role" "allteams_reader" {
  for_each = var.cluster_names

  realm_id    = data.keycloak_realm.shared.id
  client_id   = data.keycloak_openid_client.this[each.key].id
  name        = "${var.guest_organisation_name}-${var.environment_name}-allteams-reader"
  description = "Reader of all ${var.guest_organisation_name} team namespaces in the ${var.environment_name} environment Kubernetes clusters"
}

resource "keycloak_role" "allteams_writer" {
  for_each = var.cluster_names

  realm_id    = data.keycloak_realm.shared.id
  client_id   = data.keycloak_openid_client.this[each.key].id
  name        = "${var.guest_organisation_name}-${var.environment_name}-allteams-writer"
  description = "Writer of all ${var.guest_organisation_name} team namespaces in the ${var.environment_name} environment Kubernetes clusters"
}

resource "keycloak_role" "allteams_admin" {
  for_each = var.cluster_names

  realm_id    = data.keycloak_realm.shared.id
  client_id   = data.keycloak_openid_client.this[each.key].id
  name        = "${var.guest_organisation_name}-${var.environment_name}-allteams-admin"
  description = "Admin of all ${var.guest_organisation_name} team namespaces in the ${var.environment_name} Kubernetes clusters"
}
