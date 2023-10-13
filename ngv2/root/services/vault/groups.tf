resource "vault_identity_group" "org_allteams_allenvironments_admin" {
  name                       = "${var.organisation_name}-allteams-allenvironments-admins"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "org_allteams_allenvironments_admin" {
  group_id  = vault_identity_group.org_allteams_allenvironments_admin.id
  policies  = [
    vault_policy.org_allteams_allenvironments_admin.name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "org_allteams_allenvironments_admin" {
  name           = "${var.organisation_name}-allteams-allenvironments-admin"
  mount_accessor = local.auth_backend.accessor
  canonical_id   = vault_identity_group.org_allteams_allenvironments_admin.id
}

resource "vault_identity_group" "org_allteams_allenvironments_writer" {
  name                       = "${var.organisation_name}-allteams-allenvironments-writers"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "org_allteams_allenvironments_writer" {
  group_id  = vault_identity_group.org_allteams_allenvironments_writer.id
  policies  = [
    vault_policy.org_allteams_allenvironments_writer.name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "org_allteams_allenvironments_writer" {
  name           = "${var.organisation_name}-allteams-allenvironments-writer"
  mount_accessor = local.auth_backend.accessor
  canonical_id   = vault_identity_group.org_allteams_allenvironments_writer.id
}

resource "vault_identity_group" "org_allteams_allenvironments_reader" {
  name                       = "${var.organisation_name}-allteams-allenvironments-readers"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "org_allteams_allenvironments_reader" {
  group_id  = vault_identity_group.org_allteams_allenvironments_reader.id
  policies  = [
    vault_policy.org_allteams_allenvironments_reader.name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "org_allteams_allenvironments_reader" {
  name           = "${var.organisation_name}-allteams-allenvironments-reader"
  mount_accessor = local.auth_backend.accessor
  canonical_id   = vault_identity_group.org_allteams_allenvironments_reader.id
}

resource "vault_identity_group" "org_allteams_environmentspecific_admins" {
  for_each = local.environments_map

  name                       = "${var.organisation_name}-allteams-${each.value.name}-admins"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "org_allteams_environmentspecific_admins" {
  for_each = local.environments_map

  group_id  = vault_identity_group.org_allteams_environmentspecific_admins[each.key].id
  policies  = [
    vault_policy.org_allteams_environmentspecific_admins[each.key].name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "org_allteams_environmentspecific_admins" {
  for_each = local.environments_map

  name           = "${var.organisation_name}-allteams-${each.value.name}-admin"
  mount_accessor = local.auth_backend.accessor
  canonical_id   = vault_identity_group.org_allteams_environmentspecific_admins[each.key].id
}

resource "vault_identity_group" "org_allteams_environmentspecific_writers" {
  for_each = local.environments_map

  name                       = "${var.organisation_name}-allteams-${each.value.name}-writers"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "org_allteams_environmentspecific_writers" {
  for_each = local.environments_map

  group_id  = vault_identity_group.org_allteams_environmentspecific_writers[each.key].id
  policies  = [
    vault_policy.org_allteams_environmentspecific_writers[each.key].name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "org_allteams_environmentspecific_writers" {
  for_each = local.environments_map

  name           = "${var.organisation_name}-allteams-${each.value.name}-writer"
  mount_accessor = local.auth_backend.accessor
  canonical_id   = vault_identity_group.org_allteams_environmentspecific_writers[each.key].id
}

resource "vault_identity_group" "org_allteams_environmentspecific_readers" {
  for_each = local.environments_map

  name                       = "${var.organisation_name}-allteams-${each.value.name}-readers"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "org_allteams_environmentspecific_readers" {
  for_each = local.environments_map

  group_id  = vault_identity_group.org_allteams_environmentspecific_readers[each.key].id
  policies  = [
    vault_policy.org_allteams_environmentspecific_readers[each.key].name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "org_allteams_environmentspecific_readers" {
  for_each = local.environments_map

  name           = "${var.organisation_name}-allteams-${each.value.name}-reader"
  mount_accessor = local.auth_backend.accessor
  canonical_id   = vault_identity_group.org_allteams_environmentspecific_readers[each.key].id
}

resource "vault_identity_group" "org_teamspecific_allenvironments_admins" {
  for_each = local.teams_map

  name                       = "${var.organisation_name}-${each.value.name}-allenvironments-admin"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "org_teamspecific_allenvironments_admins" {
  for_each = local.teams_map

  group_id  = vault_identity_group.org_teamspecific_allenvironments_admins[each.key].id
  policies  = [
    vault_policy.org_teamspecific_allenvironments_admins[each.key].name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "org_teamspecific_allenvironments_admins" {
  for_each = local.teams_map

  name           = "${var.organisation_name}-${each.value.name}-allenvironments-admin"
  mount_accessor = local.auth_backend.accessor
  canonical_id   = vault_identity_group.org_teamspecific_allenvironments_admins[each.key].id
}

resource "vault_identity_group" "org_teamspecific_allenvironments_writers" {
  for_each = local.teams_map

  name                       = "${var.organisation_name}-${each.value.name}-allenvironments-writers"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "org_teamspecific_allenvironments_writers" {
  for_each = local.teams_map

  group_id  = vault_identity_group.org_teamspecific_allenvironments_writers[each.key].id
  policies  = [
    vault_policy.org_teamspecific_allenvironments_writers[each.key].name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "org_teamspecific_allenvironments_writers" {
  for_each = local.teams_map

  name           = "${var.organisation_name}-${each.value.name}-allenvironments-writer"
  mount_accessor = local.auth_backend.accessor
  canonical_id   = vault_identity_group.org_teamspecific_allenvironments_writers[each.key].id
}

resource "vault_identity_group" "org_teamspecific_allenvironments_readers" {
  for_each = local.teams_map

  name                       = "${var.organisation_name}-${each.value.name}-allenvironments-readers"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "org_teamspecific_allenvironments_readers" {
  for_each = local.teams_map

  group_id  = vault_identity_group.org_teamspecific_allenvironments_readers[each.key].id
  policies  = [
    vault_policy.org_teamspecific_allenvironments_readers[each.key].name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "org_teamspecific_allenvironments_readers" {
  for_each = local.teams_map

  name           = "${var.organisation_name}-${each.value.name}-allenvironments-reader"
  mount_accessor = local.auth_backend.accessor
  canonical_id   = vault_identity_group.org_teamspecific_allenvironments_readers[each.key].id
}

resource "vault_identity_group" "org_teamspecific_environmentspecific_admins" {
  for_each = local.teams_environments_merged_map

  name                       = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-admin"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "org_teamspecific_environmentspecific_admins" {
  for_each = local.teams_environments_merged_map

  group_id  = vault_identity_group.org_teamspecific_environmentspecific_admins[each.key].id
  policies  = [
    vault_policy.org_teamspecific_environmentspecific_admins[each.key].name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "org_teamspecific_environmentspecific_admins" {
  for_each = local.teams_environments_merged_map

  name           = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-admin"
  mount_accessor = local.auth_backend.accessor
  canonical_id   = vault_identity_group.org_teamspecific_environmentspecific_admins[each.key].id
}

resource "vault_identity_group" "org_teamspecific_environmentspecific_writers" {
  for_each = local.teams_environments_merged_map

  name                       = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-writers"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "org_teamspecific_environmentspecific_writers" {
  for_each = local.teams_environments_merged_map

  group_id  = vault_identity_group.org_teamspecific_environmentspecific_writers[each.key].id
  policies  = [
    vault_policy.org_teamspecific_environmentspecific_writers[each.key].name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "org_teamspecific_environmentspecific_writers" {
  for_each = local.teams_environments_merged_map

  name           = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-writer"
  mount_accessor = local.auth_backend.accessor
  canonical_id   = vault_identity_group.org_teamspecific_environmentspecific_writers[each.key].id
}

resource "vault_identity_group" "org_teamspecific_environmentspecific_readers" {
  for_each = local.teams_environments_merged_map

  name                       = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-readers"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}

resource "vault_identity_group_policies" "org_teamspecific_environmentspecific_readers" {
  for_each = local.teams_environments_merged_map

  group_id  = vault_identity_group.org_teamspecific_environmentspecific_readers[each.key].id
  policies  = [
    vault_policy.org_teamspecific_environmentspecific_readers[each.key].name
  ]
  exclusive = true
}

resource "vault_identity_group_alias" "org_teamspecific_environmentspecific_readers" {
  for_each = local.teams_environments_merged_map

  name           = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-reader"
  mount_accessor = local.auth_backend.accessor
  canonical_id   = vault_identity_group.org_teamspecific_environmentspecific_readers[each.key].id
}
