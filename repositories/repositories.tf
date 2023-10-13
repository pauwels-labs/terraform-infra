resource "github_repository" "this" {
  count = local.repo_count

  name                   = var.repository_names[count.index]
  auto_init              = true
  allow_rebase_merge     = false
  allow_squash_merge     = false
  delete_branch_on_merge = true
  visibility             = "private"
}

resource "github_branch_default" "this" {
  count = local.repo_count

  repository = github_repository.this[count.index].name
  branch     = "main"
}

resource "tls_private_key" "this" {
  count = local.total_key_count

  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "this" {
  count = local.total_key_count

  title      = var.deploy_keys[count.index % local.repo_key_count].name
  repository = github_repository.this[floor(count.index / local.repo_key_count)].name
  key        = tls_private_key.this[count.index].public_key_openssh
  read_only  = github_repository.this[floor(count.index / local.repo_key_count)].name == "team-main" && var.deploy_keys[count.index % local.repo_key_count].name == "cd" ? false : !var.deploy_keys[count.index % local.repo_key_count].rw
}

resource "local_file" "deploy_private_key_openssh" {
  count = local.total_key_count

  content  = tls_private_key.this[count.index].private_key_openssh
  filename = "${path.module}/deploy_private_key_${github_repository.this[floor(count.index / local.repo_key_count)].name}_${var.deploy_keys[count.index % local.repo_key_count].name}.openssh"
}

resource "local_file" "deploy_private_key_pem" {
  count = local.total_key_count

  content  = tls_private_key.this[count.index].private_key_pem
  filename = "${path.module}/deploy_private_key_${github_repository.this[floor(count.index / local.repo_key_count)].name}_${var.deploy_keys[count.index % local.repo_key_count].name}.pem"
}
