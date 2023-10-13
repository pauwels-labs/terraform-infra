module "github" {
  source = "./github"

  team_name              = var.team_name
  organisation_name      = var.organisation_name
  webhook_domain         = var.root_organisation_domain
  environments           = var.environments
  additional_hmac_tokens = var.additional_hmac_tokens
  repository_domain      = var.team_repository_domain
  repository_bot_name    = var.team_repository_bot_name
  repository_bot_token   = var.team_repository_bot_token
  repository_visibility  = var.team_repository_visibility
  additional_deploy_keys = var.additional_deploy_keys
  known_hosts            = var.known_hosts
}
