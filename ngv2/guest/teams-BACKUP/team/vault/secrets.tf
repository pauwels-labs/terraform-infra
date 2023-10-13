resource "vault_kv_secret_v2" "team_root" {
  mount               = var.organisation_name
  name                = "teams/${var.team_name}/root"
  delete_all_versions = true
  data_json           = jsonencode({})
}
