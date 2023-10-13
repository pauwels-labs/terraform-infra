module "this" {
  source = "./team"

  for_each = local.teams_map

  root_organisation_name     = var.root_organisation_name
  root_organisation_domain   = var.root_organisation_domain
  organisation_name          = var.organisation_name
  team_name                  = each.value.name
  environments               = each.value.environments == null ? var.default_environments : each.value.environments
  team_repository_domain     = each.value.team_repository_domain
  team_repository_bot_name   = each.value.team_repository_bot_name
  team_repository_visibility = each.value.team_repository_visibility
  additional_hmac_tokens     = each.value.additional_hmac_tokens
  additional_deploy_keys     = each.value.additional_deploy_keys
  known_hosts                = each.value.known_hosts
}
