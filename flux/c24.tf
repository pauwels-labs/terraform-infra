provider "flux" {
  alias = "c24"

  kubernetes = {
    config_path    = "~/.kube/config"
    config_context = local.cluster_create[local.cluster_index[24]] ? local.cluster_names[local.cluster_index[24]] : ""
  }
  git = {
    url   = "https://${var.repository_host_domain}/${var.org_name}/${var.repository_name}.git"
    http  = {
      username = "capt-haddock"
      password = "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"
    }
    # ssh = {
    #   username    = "git"
    #   private_key = tls_private_key.cd.private_key_pem
    # }
  }
}

resource "flux_bootstrap_git" "c24" {
  count    = local.cluster_create[local.cluster_index[24]] ? 1 : 0
  provider = flux.c24
  #depends_on = [github_repository_deploy_key.this]

  path             = "clusters/${local.cluster_names[count.index]}"
  network_policy   = false
  components_extra = [
    "image-reflector-controller",
    "image-automation-controller"
  ]
  registry         = "274295908850.dkr.ecr.eu-west-1.amazonaws.com/fluxcd"
  secret_name      = "ssh-pauwels-labs-main-github-pauwels-labs-flux-infra"
  interval         = "5m0s"
  version          = "v2.0.0-rc.5"
  kustomization_override = file("${path.module}/kustomization-override.yaml")
}
