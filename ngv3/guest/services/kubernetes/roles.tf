// Root roles
resource "keycloak_role" "infrareader" {
  count = var.is_root ? 1 : 0

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared.id
  name        = "kubernetes-${var.environment_name}-infrareader"
  description = "Reader of all infrastructure namespaces in the Kubernetes clusters in the ${var.environment_name} environment"
}

resource "keycloak_role" "infrawriter" {
  count = var.is_root ? 1 : 0

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared.id
  name        = "kubernetes-${var.environment_name}-infrawriter"
  description = "Writer of all infrastructure namespaces in the Kubernetes clusters in the ${var.environment_name} environment"
}

resource "keycloak_role" "infraadmin" {
  count = var.is_root ? 1 : 0

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared.id
  name        = "kubernetes-${var.environment_name}-infraadmin"
  description = "Admin of all infrastructure namespaces in the Kubernetes clusters in the ${var.environment_name} environment"
}

resource "keycloak_role" "superreader" {
  count = var.is_root ? 1 : 0

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared.id
  name        = "kubernetes-${var.environment_name}-superreader"
  description = "Reader of all namespaces in the Kubernetes clusters in the ${var.environment_name} environment"
}

resource "keycloak_role" "superwriter" {
  count = var.is_root ? 1 : 0

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared.id
  name        = "kubernetes-${var.environment_name}-superwriter"
  description = "Writer of all namespaces in the Kubernetes clusters in the ${var.environment_name} environment"
}

resource "keycloak_role" "superadmin" {
  count = var.is_root ? 1 : 0

  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared.id
  name        = "kubernetes-${var.environment_name}-superadmin"
  description = "Admin of all namespaces in the Kubernetes clusters in the ${var.environment_name} environment"
}

// All teams roles
resource "keycloak_role" "allteams_reader" {
  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared.id
  name        = "kubernetes-${var.environment_name}-allteams-reader"
  description = "Reader of all ${var.organisation_name} team namespaces in the Kubernetes clusters in the ${var.environment_name} environment"
}

resource "keycloak_role" "allteams_writer" {
  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared.id
  name        = "kubernetes-${var.environment_name}-allteams-writer"
  description = "Writer of all ${var.organisation_name} team namespaces in the Kubernetes clusters in the ${var.environment_name} environment"
}

resource "keycloak_role" "allteams_admin" {
  realm_id    = data.keycloak_realm.users.id
  client_id   = data.keycloak_openid_client.shared.id
  name        = "kubernetes-${var.environment_name}-allteams-admin"
  description = "Admin of all ${var.organisation_name} team namespaces in the Kubernetes clusters in the ${var.environment_name} environment"
}
