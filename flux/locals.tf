locals {
  cluster_index     = range(25)
  clusters          = data.terraform_remote_state.eks.outputs.clusters
  cluster_count     = length(local.clusters)
  cluster_region    = data.terraform_remote_state.eks.outputs.cluster_region
  cluster_base_name = data.terraform_remote_state.eks.outputs.cluster_base_name
  cluster_names     = [for c in local.clusters : c.cluster_id]
  cluster_endpoints = [for c in local.clusters : c.cluster_endpoint]
  cluster_ca_datas  = [for c in local.clusters : c.cluster_certificate_authority_data]
  cluster_create    = [for i in local.cluster_index : i + 1 <= local.cluster_count]

  cluster_account_role_arn = var.cluster_account_role_arn != "" ? var.cluster_account_role_arn : data.terraform_remote_state.eks.outputs.cluster_creator_role_arn

  known_hosts = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="

  flux_kustomize_patches = {
    kustomization = file("./patch-kustomization.yaml")
    helm          = file("./patch-helm.yaml")
    kustomize     = file("./patch-kustomize.yaml")
    notification  = file("./patch-notification.yaml")
    source        = file("./patch-source.yaml")
    namespace     = file("./patch-namespace.yaml")
    gitrepository = file("./patch-gitrepository.yaml")
  }
}
