locals {
  idp_url   = trim(var.idp_url, "/")
  vault_url = trim(var.vault_url, "/")

  teams_map = { for team in var.teams : team.name => team }
}
