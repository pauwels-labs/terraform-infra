module "tenants" {
  for_each = local.tenants_flattened_map
  source   = "./tenant"

  org_name             = var.org_name
  tenant_name          = each.value.name
  tenant_chunk         = each.value.chunk
  vault_address        = var.vault_address
  repository_bot_host  = each.value.repository_bot_host != null ? each.value.repository_bot_host : var.repository_bot_host
  repository_bot_name  = each.value.repository_bot_name != null ? each.value.repository_bot_name : var.repository_bot_name
  repository_bot_token = each.value.repository_bot_token != null ? each.value.repository_bot_token : var.repository_bot_token
}
