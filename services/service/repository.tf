resource "github_repository" "this" {
  name                   = var.service_name
  auto_init              = false
  allow_merge_commit     = true
  allow_rebase_merge     = false
  allow_squash_merge     = false
  allow_auto_merge       = false
  allow_update_branch    = true
  delete_branch_on_merge = true
  visibility             = var.service_repo_visibility
  has_issues             = true

  dynamic "template" {
    for_each = length(var.template_name) == 0 ? toset([]) : toset([1])
    content {
      owner                = var.service_repo_org_name
      repository           = "template-${var.template_name}"
      include_all_branches = false
    }
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
    "commit_comment",
    "create",
    "delete",
    "issue_comment",
    "issues",
    "label",
    "ping",
    "pull_request",
    "pull_request_review_comment",
    "pull_request_review",
    "pull_request_review_thread",
    "push",
    "release"
  ]

  configuration {
    url          = "https://webhook.ci.${var.org_domain}/${var.tenant_name}/hook"
    content_type = "json"
    secret       = data.vault_kv_secret_v2.hmac.data.token
  }
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
    url          = "https://webhook.cd.${each.key}.${var.org_domain}/hook/${sha256("${data.vault_kv_secret_v2.hmac.data.token}${local.service_repo_host_name}-${var.service_repo_org_name}-${var.service_name}${local.collapse_envs ? "-${each.key}" : ""}t-${var.tenant_name}")}"
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
