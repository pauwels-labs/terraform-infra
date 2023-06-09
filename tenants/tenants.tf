module "tenants" {
  for_each = local.tenants_flattened_map
  source   = "./tenant"

  org_name              = var.org_name
  org_domain            = var.org_domain
  vault_address         = var.vault_address
  tenant_name           = each.value.name
  tenant_chunk          = each.value.chunk
  tenant_domain         = each.value.domain != null ? each.value.domain : var.org_domain
  tenant_repo_org_name  = each.value.repo_org_name != null ? each.value.repo_org_name : var.org_name
  tenant_repo_domain    = each.value.repo_domain != null ? each.value.repo_domain : var.repo_domain
  tenant_repo_bot_name  = each.value.repo_bot_name != null ? each.value.repo_bot_name : var.repo_bot_name
  tenant_repo_bot_token = each.value.repo_bot_token != null ? each.value.repo_bot_token : var.repo_bot_token
}
