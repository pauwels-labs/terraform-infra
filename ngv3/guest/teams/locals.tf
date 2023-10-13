locals {
  idp_url = trim(var.idp_url, "/")
  teams_map = { for team in var.teams : team.name => team }
  subteams_set = toset(flatten([
    for team in var.teams : [
      for subteam in team.subteams : {
        team_name = team.name
        subteam_name = subteam
      }
    ]
  ]))
  subteams_map = {
    for subteam in local.subteams_set : "${subteam.team_name}-${subteam.subteam_name}" => subteam
  }
}
