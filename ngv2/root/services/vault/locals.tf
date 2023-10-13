locals {
  idp_url   = trim(var.idp_url, "/")
  vault_url = trim(var.vault_url, "/")

  auth_backend      = var.is_root ? vault_jwt_auth_backend.this[0] : data.vault_auth_backend.this[0]
  vault_client      = var.is_root ? keycloak_openid_client.vault_in_shared_infra_realm[0] : data.keycloak_openid_client.vault_in_shared_infra_realm[0]

  environments_map  = {
    for environment in var.environments : environment.name => environment
  }
  teams_map  = {
    for team in var.teams : team.name => team
  }

  teams_environments_merged  = flatten([
    for environment in var.environments : [
      for team in var.teams : {
        team        = team
        environment = environment
      }
    ]
  ])
  teams_environments_merged_map = {
    for glob in local.teams_environments_merged : "${glob.team.name}-${glob.environment.name}" => glob
  }
}
