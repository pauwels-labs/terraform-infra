resource "aws_eks_identity_provider_config" "keycloak" {
  provider = aws.cluster

  count = data.terraform_remote_state.eks.outputs.cluster_count

  cluster_name = data.terraform_remote_state.eks.outputs.clusters[count.index].cluster_id

  oidc {
    client_id                     = "kubernetes"
    groups_claim                  = "roles"
    groups_prefix                 = "oidc:"
    identity_provider_config_name = "keycloak"
    issuer_url                    = "${local.idp_url}/realms/${data.terraform_remote_state.idp.outputs.environment_realms[var.environment_name].realm}"
    username_claim                = "preferred_username"
    username_prefix               = "oidc:"
  }
}
