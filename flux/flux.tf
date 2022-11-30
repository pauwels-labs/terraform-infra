data "flux_install" "this" {
  count = local.cluster_count

  target_path      = "clusters/${local.cluster_names[count.index]}"
  network_policy   = false
  components_extra = [
    "image-reflector-controller",
    "image-automation-controller"
  ]
}

data "kubectl_file_documents" "install_content" {
  count = local.cluster_count

  content = data.flux_install.this[count.index].content
}

data "flux_sync" "this" {
  count = local.cluster_count

  branch      = "main"
  target_path = "clusters/${local.cluster_names[count.index]}"
  url         = "ssh://git@github.com/${var.github_org_name}/${var.github_repository_name}"
  secret      = "ssh-pauwels-labs-main-github-pauwels-labs-flux-infra"
  patch_names = keys(local.flux_kustomize_patches)
  interval    = 5
}

data "kubectl_file_documents" "sync_content" {
  count = local.cluster_count

  content = data.flux_sync.this[count.index].content
}

data "kubectl_file_documents" "kustomize_content" {
  count = local.cluster_count

  content = data.flux_sync.this[count.index].kustomize_content
}

resource "github_repository_file" "flux_install_content" {
  count = local.cluster_count

  repository     = var.github_repository_name
  file           = data.flux_install.this[count.index].path
  content        = data.flux_install.this[count.index].content
  branch         = "main"
  commit_message = "feat: bootstraps flux install into the cluster"
}

resource "github_repository_file" "flux_sync_content" {
  count = local.cluster_count

  repository     = var.github_repository_name
  file           = data.flux_sync.this[count.index].path
  content        = data.flux_sync.this[count.index].content
  branch         = "main"
  commit_message = "feat: bootstraps flux sync into the cluster"
}

resource "github_repository_file" "flux_sync_kustomize_content" {
  count = local.cluster_count

  repository     = var.github_repository_name
  file           = data.flux_sync.this[count.index].kustomize_path
  # We need to add the ecr-credentials-sync repo here but flux_sync won't let
  # us add to the .resources array, so manually defining it here instead
  #content        = data.flux_sync.this[count.index].kustomize_content
  content        = <<-EOT
    apiVersion: kustomize.config.k8s.io/v1beta1
    kind: Kustomization
    resources:
    - gitrepository-ecr-credentials-sync.yaml
    - gotk-sync.yaml
    - gotk-components.yaml
    patchesStrategicMerge:
    - patch-helm.yaml
    - patch-kustomize.yaml
    - patch-gitrepository.yaml
    - patch-source.yaml
    - patch-namespace.yaml
    - patch-notification.yaml
    - patch-kustomization.yaml
  EOT

  branch         = "main"
  commit_message = "feat: bootstraps flux kustomization into the cluster"
}

resource "github_repository_file" "flux_sync_kustomize_patches" {
  count = local.cluster_count * length(keys(local.flux_kustomize_patches))

  repository     = var.github_repository_name
  file           = data.flux_sync.this[floor(count.index / length(keys(local.flux_kustomize_patches)))].patch_file_paths[keys(local.flux_kustomize_patches)[count.index % length(keys(local.flux_kustomize_patches))]]
  content        = values(local.flux_kustomize_patches)[count.index % length(keys(local.flux_kustomize_patches))]
  branch         = "main"
  commit_message = "feat: bootstraps patches to flux into the cluster"
}

# resource "tls_private_key" "flux_infra_deploy_key" {
#   count = local.cluster_count

#   algorithm   = "ECDSA"
#   ecdsa_curve = "P256"
# }

# resource "github_repository_deploy_key" "main" {
#   count = local.cluster_count
  
#   title      = local.cluster_names[count.index]
#   repository = var.github_repository_name
#   key        = tls_private_key.flux_infra_deploy_key[count.index].public_key_openssh
#   read_only  = true
# }

# resource "local_file" "deploy_private_key_openssh" {
#   count = local.cluster_count

#   content  = tls_private_key.flux_infra_deploy_key[count.index].private_key_openssh
#   filename = "${path.module}/flux_infra_deploy_private_key_${local.cluster_names[count.index]}.openssh"
# }

# resource "local_file" "deploy_private_key_pem" {
#   count = local.cluster_count

#   content  = tls_private_key.flux_infra_deploy_key[count.index].private_key_pem
#   filename = "${path.module}/flux_infra_deploy_private_key_${local.cluster_names[count.index]}.pem"
# }
