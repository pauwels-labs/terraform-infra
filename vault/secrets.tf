resource "vault_kv_secret_v2" "team_roots" {
  for_each = local.teams_map

  mount     = vault_mount.this.path
  name      = "teams/${each.value.name}/root"
  data_json = "{}"
}
