locals {
  idp_url                       = trim(var.idp_url, "/")

  created_role_environments_mapped = { for environment in var.created_role_environments : environment.name => environment }

  subteams_assignments_map = {
    for assignment in var.role_assignments : assignment.subteam_name => assignment if assignment.subteam_name != null
  }
  team_assignments_set     = [
    for assignment in var.role_assignments : assignment if assignment.subteam_name == null
  ]
  team_assignments         = length(local.team_assignments_set) > 0 ? local.team_assignments_set[0] : null

  root_roles_set     = flatten([
    for assignment in var.role_assignments : [
      for role in assignment.roles : role if role.is_root
    ]
  ])
  root_roles_map     = {
    for role in local.root_roles_set : "kubernetes-${role.environment}-${role.name}" => role
  }
  allteams_roles_set = flatten([
    for assignment in var.role_assignments : [
      for role in assignment.roles : role if role.is_allteams
    ]
  ])
  allteams_roles_map = {
    for role in local.allteams_roles_set : "kubernetes-${role.environment}-allteams-${role.name}" => role
  }
  teams_roles_set    = flatten([
    for assignment in var.role_assignments : [
      for role in assignment.roles : role if !role.is_root && !role.is_allteams
    ]
  ])
  teams_roles_map    = {
    for role in local.teams_roles_set : "kubernetes-${role.environment}-${role.team_name != null ? role.team_name : var.team_name}-${role.name}" => role
  }
}
