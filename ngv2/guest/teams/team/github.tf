module "github" {
  source = "./github"

  organisation_name      = var.organisation_name
  team_name              = var.team_name
  webhook_domain         = var.root_organisation_domain
  environments           = var.environments
  repository_domain      = var.team_repository_domain
  repository_bot_name    = var.team_repository_bot_name
  repository_visibility  = var.team_repository_visibility
  additional_hmac_tokens = var.additional_hmac_tokens
  additional_deploy_keys = var.additional_deploy_keys
  known_hosts            = var.known_hosts
}
