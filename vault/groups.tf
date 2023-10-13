resource "vault_identity_group" "team_environment_admin" {
  for_each = local.environments_teams_merged_map

  name                       = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-admin"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "team_environment_admin" {
  for_each = local.environments_teams_merged_map

  group_id  = vault_identity_group.team_environment_admin[each.key].id
  policies  = [
    vault_policy.team_environment_admin[each.key].name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "team_environment_admin" {
  for_each = local.environments_teams_merged_map

  name           = "${var.organisation_name}-${each.value.team.name}-admin"
  mount_accessor = vault_jwt_auth_backend.environments[each.value.environment.name].accessor
  canonical_id   = vault_identity_group.team_environment_admin[each.key].id
}

resource "vault_identity_group" "team_environment_writer" {
  for_each = local.environments_teams_merged_map

  name                       = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-writer"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "team_environment_writer" {
  for_each = local.environments_teams_merged_map

  group_id  = vault_identity_group.team_environment_writer[each.key].id
  policies  = [
    vault_policy.team_environment_writer[each.key].name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "team_environment_writer" {
  for_each = local.environments_teams_merged_map

  name           = "${var.organisation_name}-${each.value.team.name}-writer"
  mount_accessor = vault_jwt_auth_backend.environments[each.value.environment.name].accessor
  canonical_id   = vault_identity_group.team_environment_writer[each.key].id
}

resource "vault_identity_group" "team_environment_reader" {
  for_each = local.environments_teams_merged_map

  name                       = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-reader"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_alias" "team_environment_reader" {
  for_each = local.environments_teams_merged_map

  name           = "${var.organisation_name}-${each.value.team.name}-reader"
  mount_accessor = vault_jwt_auth_backend.environments[each.value.environment.name].accessor
  canonical_id   = vault_identity_group.team_environment_reader[each.key].id
}

resource "vault_identity_group_policies" "team_environment_reader" {
  for_each = local.environments_teams_merged_map

  group_id  = vault_identity_group.team_environment_reader[each.key].id
  policies  = [
    vault_policy.team_environment_reader[each.key].name
  ]
  exclusive = true
}
