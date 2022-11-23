resource "github_repository" "flux_infra" {
  name      = local.flux_infra_repository_name
  auto_init = true
}

resource "github_branch_default" "flux_infra" {
  repository = github_repository.flux_infra.name
  branch     = "main"
}

resource "github_repository" "team_main" {
  name      = local.team_main_repository_name
  auto_init = true
}

resource "github_branch_default" "team_main" {
  repository = github_repository.team_main.name
  branch     = "main"
}

resource "tls_private_key" "team_main_deploy_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "team_main" {
  title      = "bill-0"
  repository = github_repository.team_main.name
  key        = tls_private_key.team_main_deploy_key.public_key_openssh
  read_only  = true
}

resource "local_file" "team_main_deploy_private_key_openssh" {
  content  = tls_private_key.team_main_deploy_key.private_key_openssh
  filename = "${path.module}/team_main_deploy_private_key.openssh"
}

resource "local_file" "team_main_deploy_private_key_pem" {
  content  = tls_private_key.team_main_deploy_key.private_key_pem
  filename = "${path.module}/team_main_deploy_private_key.pem"
}

resource "github_repository" "homepage" {
  name      = "homepage"
  auto_init = true
  
  allow_rebase_merge     = false
  allow_squash_merge     = false
  delete_branch_on_merge = true
  vulnerability_alerts   = false
}

resource "github_branch_default" "homepage" {
  repository = github_repository.homepage.name
  branch     = "main"
}

resource "tls_private_key" "homepage_deploy_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "homepage" {
  title      = "bill-0"
  repository = github_repository.homepage.name
  key        = tls_private_key.homepage_deploy_key.public_key_openssh
  read_only  = true
}

resource "local_file" "homepage_deploy_private_key_openssh" {
  content  = tls_private_key.homepage_deploy_key.private_key_openssh
  filename = "${path.module}/homepage_deploy_private_key.openssh"
}

resource "local_file" "homepage_deploy_private_key_pem" {
  content  = tls_private_key.homepage_deploy_key.private_key_pem
  filename = "${path.module}/homepage_deploy_private_key.pem"
}
