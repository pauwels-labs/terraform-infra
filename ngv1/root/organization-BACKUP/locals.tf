locals {
  organisation_display_name  = length(var.organisation_display_name) > 0 ? var.organisation_display_name : var.organisation_name
  idp_url                    = trim(var.idp_url, "/")
  # environments_map           = { for environment in var.environments : environment.name => environment }
  services_map               = { for service in var.services : service.name => service }
  # teams_map                  = { for team in var.teams : team.name => team }
  # users_map                  = { for user in var.users : user.username => user }

  # environments_services_teams_merged    = flatten([
  #   for environment in var.environments : [
  #     for service in var.services : [
  #       for team in var.teams : {
  #         environment = environment,
  #         team        = team,
  #         service     = service
  #       }
  #     ] if contains(environment.services, service.name)
  #   ]
  # ])
  # environments_services_teams_merged_map = {
  #   for glob in local.environments_services_teams_merged : "${glob.environment.name}-${glob.service.name}-${glob.team.name}" => glob
  # }

  # environments_services_merged    = flatten([
  #   for environment in var.environments : [
  #     for service in var.services : {
  #         environment = environment,
  #         service     = service
  #     } if contains(environment.services, service.name)
  #   ]
  # ])
  # environments_services_merged_map = {
  #   for glob in local.environments_services_merged : "${glob.environment.name}-${glob.service.name}" => glob
  # }

  # environments_teams_merged     = flatten([
  #   for environment in var.environments : [
  #     for team in var.teams : {
  #         environment = environment,
  #         team        = team
  #     }
  #   ]
  # ])
  # environments_teams_merged_map = {
  #   for glob in local.environments_teams_merged : "${glob.environment.name}-${glob.team.name}" => glob
  # }
}
