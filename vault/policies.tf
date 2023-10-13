resource "vault_policy" "team_environment_admin" {
  for_each = local.environments_teams_merged_map

  name = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-admin"
  policy = <<EOF
path "/${var.organisation_name}/data/*" {
  capabilities = [${each.value.environment.allow_list_from_root ? "\"list\"" : ""}]
}
path "/${var.organisation_name}/metadata/*" {
  capabilities = [${each.value.environment.allow_list_from_root ? "\"list\"" : ""}]
}
path "/${var.organisation_name}/data/teams/${each.value.team.name}/*" {
  capabilities = [${each.value.environment.true_admin_access ? "\"create\", \"read\", \"update\", \"delete\", \"list\"" : "\"list\""}]
}
path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/*" {
  capabilities = [${each.value.environment.true_admin_access ? "\"create\", \"read\", \"update\", \"delete\", \"list\"" : "\"list\""}]
}
path "/${var.organisation_name}/data/teams/${each.value.team.name}/configs/${each.value.environment.name}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/configs/${each.value.environment.name}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "/${var.organisation_name}/data/teams/${each.value.team.name}/configs/base/*" {
  capabilities = [${each.value.environment.true_admin_access ? "\"create\", \"read\", \"update\", \"delete\", \"list\"" : "\"read\", \"list\""}]
}
path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/configs/base/*" {
  capabilities = [${each.value.environment.true_admin_access ? "\"create\", \"read\", \"update\", \"delete\", \"list\"" : "\"read\", \"list\""}]
}
EOF
}

resource "vault_policy" "team_environment_writer" {
  for_each = local.environments_teams_merged_map

  name = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-writer"
  policy = <<EOT
path "/${var.organisation_name}/data/*" {
  capabilities = [${each.value.environment.allow_list_from_root ? "\"list\"" : ""}]
}
path "/${var.organisation_name}/metadata/*" {
  capabilities = [${each.value.environment.allow_list_from_root ? "\"list\"" : ""}]
}
path "/${var.organisation_name}/data/teams/${each.value.team.name}/*" {
  capabilities = ["list"]
}
path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/*" {
  capabilities = ["list"]
}
path "/${var.organisation_name}/data/teams/${each.value.team.name}/configs/${each.value.environment.name}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/configs/${each.value.environment.name}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "/${var.organisation_name}/data/teams/${each.value.team.name}/configs/base/*" {
  capabilities = ["read", "list"]
}
path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/configs/base/*" {
  capabilities = ["read", "list"]
}
EOT
}

resource "vault_policy" "team_environment_reader" {
  for_each = local.environments_teams_merged_map

  name = "${var.organisation_name}-${each.value.team.name}-${each.value.environment.name}-reader"
  policy = <<EOT
path "/${var.organisation_name}/data/*" {
  capabilities = [${each.value.environment.allow_list_from_root ? "\"list\"" : ""}]
}
path "/${var.organisation_name}/metadata/*" {
  capabilities = [${each.value.environment.allow_list_from_root ? "\"list\"" : ""}]
}
path "/${var.organisation_name}/data/teams/${each.value.team.name}/*" {
  capabilities = ["list"]
}
path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/*" {
  capabilities = ["list"]
}
path "/${var.organisation_name}/data/teams/${each.value.team.name}/configs/${each.value.environment.name}/*" {
  capabilities = ["read", "list"]
}
path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/configs/${each.value.environment.name}/*" {
  capabilities = ["read", "list"]
}
path "/${var.organisation_name}/data/teams/${each.value.team.name}/configs/base/*" {
  capabilities = ["read", "list"]
}
path "/${var.organisation_name}/metadata/teams/${each.value.team.name}/configs/base/*" {
  capabilities = ["read", "list"]
}
EOT
}
