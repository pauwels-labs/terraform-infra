resource "github_repository" "this" {
  name                   = "tenant-${var.tenant_name}"
  auto_init              = false
  allow_rebase_merge     = false
  allow_squash_merge     = false
  delete_branch_on_merge = true
  visibility             = var.tenant_repo_visibility

  template {
    owner                = var.org_name
    repository           = "template-tenant"
    include_all_branches = false
  }
}

resource "github_branch_default" "this" {
  repository = github_repository.this.name
  branch     = "main"
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

resource "github_repository_webhook" "cd" {
  for_each = local.env_map

  repository = github_repository.this.name
  active     = true
  events     = [
    "ping",
    "push"
  ]

  configuration {
    url          = "https://webhook.cd.${each.key}.${var.org_domain}/hook/${sha256("${random_password.hmac_tokens["primary"].result}${local.tenant_repo_host_name}-${var.tenant_repo_org_name}-tenant-${var.tenant_name}t-${var.tenant_name}")}"
    content_type = "json"
    secret       = random_password.hmac_tokens["primary"].result
  }
}
