resource "aws_eks_identity_provider_config" "keycloak" {
  provider = aws.cluster

  for_each = var.cluster_names

  cluster_name = "${each.key}-0"

  oidc {
    client_id                     = "kubernetes-${each.key}"
    groups_claim                  = "roles"
    groups_prefix                 = "oidc:"
    identity_provider_config_name = "keycloak"
    issuer_url                    = "${local.idp_url}/realms/${data.keycloak_realm.shared.id}"
    username_claim                = "preferred_username"
    username_prefix               = "oidc:"
  }
}
