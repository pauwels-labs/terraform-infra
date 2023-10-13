data "keycloak_openid_client" "this" {
  for_each = local.cluster_names_set

  realm_id  = data.keycloak_realm.shared.id
  client_id = "kubernetes-${each.key}"
}
