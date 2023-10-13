// Roles inside kubernetes clients in the shared realm
resource "keycloak_role" "infrareader" {
  for_each = var.cluster_names

  realm_id    = data.keycloak_realm.shared.id
  client_id   = keycloak_openid_client.this[each.key].id
  name        = "infrareader"
  description = "Reader of all infrastructure namespaces in the cluster"
}

resource "keycloak_role" "infrawriter" {
  for_each = var.cluster_names

  realm_id    = data.keycloak_realm.shared.id
  client_id   = keycloak_openid_client.this[each.key].id
  name        = "infrawriter"
  description = "Writer of all infrastructure namespaces in the cluster"
}

resource "keycloak_role" "infraadmin" {
  for_each = var.cluster_names

  realm_id    = data.keycloak_realm.shared.id
  client_id   = keycloak_openid_client.this[each.key].id
  name        = "infraadmin"
  description = "Admin of all infrastructure namespaces in the cluster"
}

resource "keycloak_role" "superreader" {
  for_each = var.cluster_names

  realm_id    = data.keycloak_realm.shared.id
  client_id   = keycloak_openid_client.this[each.key].id
  name        = "superreader"
  description = "Reader of all namespaces in the cluster"
}

resource "keycloak_role" "superwriter" {
  for_each = var.cluster_names

  realm_id    = data.keycloak_realm.shared.id
  client_id   = keycloak_openid_client.this[each.key].id
  name        = "superwriter"
  description = "Writer of all namespaces in the cluster"
}

resource "keycloak_role" "superadmin" {
  for_each = var.cluster_names

  realm_id    = data.keycloak_realm.shared.id
  client_id   = keycloak_openid_client.this[each.key].id
  name        = "superadmin"
  description = "Admin of all namespaces in the cluster"
}
