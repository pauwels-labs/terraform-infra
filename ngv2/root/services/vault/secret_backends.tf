resource "vault_mount" "this" {
  path        = var.organisation_name
  type        = "kv-v2"
  description = "Secret store for the ${var.organisation_name} organisation"
}

resource "vault_kv_secret_backend_v2" "this" {
  mount        = vault_mount.this.path
  max_versions = 10
  cas_required = false
}
