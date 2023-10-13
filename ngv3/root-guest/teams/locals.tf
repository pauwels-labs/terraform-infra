locals {
  teams_flattened = flatten([
    for chunk, teams in var.teams_by_chunk : [
      for team in teams : merge({"chunk" = chunk}, team)
    ]
  ])
  teams_flattened_map = {
    for team in local.teams_flattened : "${team.chunk}-${team.name}" => team
  }
}
