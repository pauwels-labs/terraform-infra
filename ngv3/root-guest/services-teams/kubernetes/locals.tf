locals {
  idp_url                       = trim(var.idp_url, "/")
  cluster_names_set = toset(flatten([
    for ec in var.environments_clusters : [
      for cluster in ec.clusters : cluster
    ]
  ]))
  roles_set         = toset(flatten([
    for ec in var.environments_clusters : [
      for cluster in ec.clusters: {
        environment_name  = ec.environment_name
        create_team_roles = ec.create_team_roles
        cluster_name      = cluster
      }
    ]
  ]))
  roles_map         = {
    for role in local.roles_set : "${role.cluster_name}-${role.environment_name}" => role if role.create_team_roles
  }
}
