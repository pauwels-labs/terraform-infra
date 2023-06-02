resource "github_repository" "this" {
  name                   = var.repository_name
  auto_init              = false
  allow_rebase_merge     = false
  allow_squash_merge     = false
  delete_branch_on_merge = true

  template {
    owner                = var.org_name
    repository           = var.template_name
    include_all_branches = false
  }
}

resource "github_branch_default" "this" {
  repository = github_repository.this.name
  branch     = "main"
}

resource "github_repository_webhook" "ci" {
  repository = github_repository.this.name
  active     = true
  events     = [
    "push"
  ]

  configuration {
    url          = local.ci_webhook_url
    content_type = "json"
    secret       = data.vault_kv_secret_v2.hmac.data.token
  }
}

resource "tls_private_key" "this" {
  count = local.key_count

  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "this" {
  count = local.key_count

  title      = local.deploy_keys[count.index].name
  repository = github_repository.this.name
  key        = tls_private_key.this[count.index].public_key_openssh
  read_only  = !local.deploy_keys[count.index].rw
}

resource "local_file" "deploy_private_key_openssh" {
  count = local.key_count

  content  = tls_private_key.this[count.index].private_key_openssh
  filename = "${path.root}/deploy_private_key_${github_repository.this.name}_${local.deploy_keys[count.index].name}.openssh"
}

resource "local_file" "deploy_private_key_pem" {
  count = local.key_count

  content  = tls_private_key.this[count.index].private_key_pem
  filename = "${path.root}/deploy_private_key_${github_repository.this.name}_${local.deploy_keys[count.index].name}.pem"
}
