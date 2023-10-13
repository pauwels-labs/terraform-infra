locals {
  idp_url          = trim(var.idp_url, "/")
  vault_url        = trim(var.vault_url, "/")
  environments_map = { for environment in var.environments : environment.name => environment }
  teams_map        = { for team in var.teams : team.name => team }

  environments_teams_merged     = flatten([
    for environment in var.environments : [
      for team in var.teams : {
          environment = environment,
          team        = team
      }
    ]
  ])
  environments_teams_merged_map = {
    for glob in local.environments_teams_merged : "${glob.environment.name}-${glob.team.name}" => glob
  }
}
