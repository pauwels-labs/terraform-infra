data "flux_install" "this" {
  count = local.cluster_count

  target_path    = "clusters/${local.cluster_names[count.index]}"
  network_policy = false
}

data "kubectl_file_documents" "install_content" {
  count = local.cluster_count

  content = data.flux_install.this[count.index].content
}

data "flux_sync" "this" {
  count = local.cluster_count

  branch      = "main"
  target_path = "clusters/${local.cluster_names[count.index]}"
  url         = "ssh://git@github.com/${var.github_org_name}/${data.terraform_remote_state.repositories.outputs.flux_infra_repository_name}"
  patch_names = keys(local.flux_kustomize_patches)
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

  repository     = data.terraform_remote_state.repositories.outputs.flux_infra_repository_name
  file           = data.flux_install.this[count.index].path
  content        = data.flux_install.this[count.index].content
  branch         = "main"
  commit_message = "feat: bootstraps flux install into the cluster"
}

resource "github_repository_file" "flux_sync_content" {
  count = local.cluster_count

  repository     = data.terraform_remote_state.repositories.outputs.flux_infra_repository_name
  file           = data.flux_sync.this[count.index].path
  content        = data.flux_sync.this[count.index].content
  branch         = "main"
  commit_message = "feat: bootstraps flux sync into the cluster"
}

resource "github_repository_file" "flux_sync_kustomize_content" {
  count = local.cluster_count

  repository     = data.terraform_remote_state.repositories.outputs.flux_infra_repository_name
  file           = data.flux_sync.this[count.index].kustomize_path
  content        = data.flux_sync.this[count.index].kustomize_content
  branch         = "main"
  commit_message = "feat: bootstraps flux kustomization into the cluster"
}

resource "github_repository_file" "flux_sync_kustomize_patches" {
  count = local.cluster_count * length(keys(local.flux_kustomize_patches))

  repository     = data.terraform_remote_state.repositories.outputs.flux_infra_repository_name
  file           = data.flux_sync.this[floor(count.index / length(keys(local.flux_kustomize_patches)))].patch_file_paths[keys(local.flux_kustomize_patches)[count.index % length(keys(local.flux_kustomize_patches))]]
  content        = values(local.flux_kustomize_patches)[count.index % length(keys(local.flux_kustomize_patches))]
  branch         = "main"
  commit_message = "feat: bootstraps patches to flux into the cluster"
}

resource "tls_private_key" "flux_infra_deploy_key" {
  count = local.cluster_count

  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "main" {
  count = local.cluster_count
  
  title      = local.cluster_names[count.index]
  repository = data.terraform_remote_state.repositories.outputs.flux_infra_repository_name
  key        = tls_private_key.flux_infra_deploy_key[count.index].public_key_openssh
  read_only  = true
}
