resource "aws_eks_identity_provider_config" "keycloak" {
  provider = aws.cluster

  count = data.terraform_remote_state.eks.outputs.cluster_count

  cluster_name = data.terraform_remote_state.eks.outputs.clusters[count.index].cluster_id

  oidc {
    client_id                     = keycloak_openid_client.kubernetes.client_id
    groups_claim                  = "groups"
    groups_prefix                 = "oidc:"
    identity_provider_config_name = "keycloak"
    issuer_url                    = "https://identity.pauwelslabs.com/realms/pauwels-labs-main"
    username_claim                = "user_id"
    username_prefix               = "oidc:"
  }
}
