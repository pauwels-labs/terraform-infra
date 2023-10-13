resource "github_repository" "this" {
  name                   = "team-${var.team_name}"
  auto_init              = false
  allow_rebase_merge     = false
  allow_squash_merge     = false
  delete_branch_on_merge = true
  visibility             = var.repository_visibility

  template {
    owner                = var.organisation_name
    repository           = "template-team"
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
  for_each = local.environments_map

  repository = github_repository.this.name
  active     = true
  events     = [
    "ping",
    "push"
  ]

  configuration {
    url          = "https://webhook.cd.${each.value.name}.${var.webhook_domain}/hook/${sha256("${random_password.hmac_tokens["primary"].result}${var.repository_domain}-${var.organisation_name}-team-${var.team_name}${var.team_name}")}"
    content_type = "json"
    secret       = random_password.hmac_tokens["primary"].result
  }
}
