data "keycloak_openid_client" "this" {
  for_each = var.cluster_names

  realm_id  = data.keycloak_realm.shared.id
  client_id = "kubernetes-${each.key}"
}
