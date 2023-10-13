resource "vault_policy" "org_allteams_allenvironments_admin" {
  name   = "${var.organisation_name}-allteams-allenvironments-admin"
  policy = <<EOF
path "/${var.organisation_name}/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "/${var.organisation_name}/metadata/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOF
}

resource "vault_policy" "org_allteams_allenvironments_writer" {
  name   = "${var.organisation_name}-allteams-allenvironments-writer"
  policy = <<EOF
path "/${var.organisation_name}/data/*" {
  capabilities = ["read", "update", "list"]
}

path "/${var.organisation_name}/metadata/*" {
  capabilities = ["read", "update", "list"]
}
EOF
}

resource "vault_policy" "org_allteams_allenvironments_reader" {
  name   = "${var.organisation_name}-allteams-allenvironments-reader"
  policy = <<EOF
path "/${var.organisation_name}/data/*" {
  capabilities = ["read", "list"]
}

path "/${var.organisation_name}/metadata/*" {
  capabilities = ["read", "list"]
}
EOF
}

resource "vault_policy" "org_allteams_environmentspecific_admins" {
  for_each = local.environments_map

  name   = "${var.organisation_name}-allteams-${each.value.name}-admin"
  policy = <<EOF
path "/${var.organisation_name}/data/teams/+/config/base/*" {
  capabilities = [${each.value.is_prod ? "\"create\", \"read\", \"update\", \"delete\", \"list\"" : ""}]
}

path "/${var.organisation_name}/metadata/teams/+/config/base/*" {
  capabilities = [${each.value.is_prod ? "\"create\", \"read\", \"update\", \"delete\", \"list\"" : ""}]
}

path "/${var.organisation_name}/data/teams/+/config/${each.value.name}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "/${var.organisation_name}/metadata/teams/+/config/${each.value.name}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOF
}

resource "vault_policy" "org_allteams_environmentspecific_writers" {
  for_each = local.environments_map

  name   = "${var.organisation_name}-allteams-${each.value.name}-writer"
  policy = <<EOF
path "/${var.organisation_name}/data/teams/+/config/base/*" {
  capabilities = [${each.value.is_prod ? "\"read\", \"update\", \"list\"" : ""}]
}

path "/${var.organisation_name}/metadata/teams/+/config/base/*" {
  capabilities = [${each.value.is_prod ? "\"read\", \"update\", \"list\"" : ""}]
}

path "/${var.organisation_name}/data/teams/+/config/${each.value.name}/*" {
  capabilities = ["read", "update", "list"]
}

path "/${var.organisation_name}/metadata/teams/+/config/${each.value.name}/*" {
  capabilities = ["read", "update", "list"]
}
EOF
}

resource "vault_policy" "org_allteams_environmentspecific_readers" {
  for_each = local.environments_map

  name   = "${var.organisation_name}-allteams-${each.value.name}-reader"
  policy = <<EOF
path "/${var.organisation_name}/data/teams/+/config/base/*" {
  capabilities = [${each.value.is_prod ? "\"read\", \"list\"" : ""}]
}

path "/${var.organisation_name}/metadata/teams/+/config/base/*" {
  capabilities = [${each.value.is_prod ? "\"read\", \"list\"" : ""}]
}

path "/${var.organisation_name}/data/teams/+/config/${each.value.name}/*" {
  capabilities = ["read", "list"]
}

path "/${var.organisation_name}/metadata/teams/+/config/${each.value.name}/*" {
  capabilities = ["read", "list"]
}
EOF
}

resource "vault_policy" "org_teamspecific_allenvironments_admins" {
  for_each = local.teams_map

  name   = "${var.organisation_name}-${each.value.name}-allenvironments-admin"
  policy = <<EOF
path "/${var.organisation_name}/data/teams/${each.value.name}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "/${var.organisation_name}/metadata/teams/${each.value.name}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOF
}

resource "vault_policy" "org_teamspecific_allenvironments_writers" {
  for_each = local.teams_map

  name   = "${var.organisation_name}-${each.value.name}-allenvironments-writer"
  policy = <<EOF
path "/${var.organisation_name}/data/teams/${each.value.name}/*" {
  capabilities = ["read", "update", "list"]
}

path "/${var.organisation_name}/metadata/teams/${each.value.name}/*" {
  capabilities = ["read", "update", "list"]
}
EOF
}

resource "vault_policy" "org_teamspecific_allenvironments_readers" {
  for_each = local.teams_map

  name   = "${var.organisation_name}-${each.value.name}-allenvironments-reader"
  policy = <<EOF
path "/${var.organisation_name}/data/teams/${each.value.name}/*" {
  capabilities = ["read", "list"]
}

path "/${var.organisation_name}/metadata/teams/${each.value.name}/*" {
  capabilities = ["read", "list"]
}
EOF
}

resource "vault_policy" "org_teamspecific_environmentspecific_admins" {
  for_each = local.teams_environments_merged_map

  name   = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-admin"
  policy = <<EOF
path "/${var.organisation_name}/data/teams/${each.value.team.name}/config/base/*" {
  capabilities = [${each.value.environment.is_prod ? "\"create\", \"read\", \"update\", \"delete\", \"list\"" : ""}]
}

path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/config/base/*" {
  capabilities = [${each.value.environment.is_prod ? "\"create\", \"read\", \"update\", \"delete\", \"list\"" : ""}]
}

path "/${var.organisation_name}/data/teams/${each.value.team.name}/config/${each.value.environment.name}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/config/${each.value.environment.name}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOF
}

resource "vault_policy" "org_teamspecific_environmentspecific_writers" {
  for_each = local.teams_environments_merged_map

  name   = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-writer"
  policy = <<EOF
path "/${var.organisation_name}/data/teams/${each.value.team.name}/config/base/*" {
  capabilities = [${each.value.environment.is_prod ? "\"read\", \"update\", \"list\"" : ""}]
}

path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/config/base/*" {
  capabilities = [${each.value.environment.is_prod ? "\"read\", \"update\", \"list\"" : ""}]
}

path "/${var.organisation_name}/data/teams/${each.value.team.name}/config/${each.value.environment.name}/*" {
  capabilities = ["read", "update", "list"]
}

path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/config/${each.value.environment.name}/*" {
  capabilities = ["read", "update", "list"]
}
EOF
}

resource "vault_policy" "org_teamspecific_environmentspecific_readers" {
  for_each = local.teams_environments_merged_map

  name   = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-reader"
  policy = <<EOF
path "/${var.organisation_name}/data/teams/${each.value.team.name}/config/base/*" {
  capabilities = [${each.value.environment.is_prod ? "\"read\", \"list\"" : ""}]
}

path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/config/base/*" {
  capabilities = [${each.value.environment.is_prod ? "\"read\", \"list\"" : ""}]
}

path "/${var.organisation_name}/data/teams/${each.value.team.name}/config/${each.value.environment.name}/*" {
  capabilities = ["read", "list"]
}

path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/config/${each.value.environment.name}/*" {
  capabilities = ["read", "list"]
}
EOF
}
