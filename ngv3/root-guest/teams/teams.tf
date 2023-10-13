module "teams" {
  for_each = local.teams_flattened_map
  source   = "./team"

  organisation_name            = var.organisation_name
  organisation_domain          = var.organisation_domain
  # vault_address              = var.vault_address
  team_name                    = each.value.name
  team_chunk                   = each.value.chunk
  repository_organisation_name = each.value.repository_organisation_name != null ? each.value.repository_organisation_name : var.organisation_name
  repository_domain            = each.value.repository_domain != null ? each.value.repository_domain : var.repository_domain
  repository_bot_name          = each.value.repository_bot_name != null ? each.value.repository_bot_name : var.repository_bot_name
  repository_bot_token         = each.value.repository_bot_token != null ? each.value.repository_bot_token : var.repository_bot_token
}
