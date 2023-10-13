locals {
  idp_url = trim(var.idp_url, "/")

  users_map = { for user in var.users : user.username => user }
  teams_set = toset(flatten([
    for user in var.users : [
      for team in user.teams : team
    ]
  ]))
  teams_map = {
    for team in local.teams_set : "${team.team_name}${team.subteam_name == null ? "" : format("-%s", team.subteam_name)}" => team
  }
}
