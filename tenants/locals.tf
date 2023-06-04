locals {
  tenants_flattened = flatten([
    for chunk, tenants in var.tenants_by_chunk : [
      for tenant in tenants : merge({"chunk" = chunk}, tenant)
    ]
  ])
  tenants_flattened_map = {
    for tenant in local.tenants_flattened : "${tenant.chunk}-${tenant.name}" => tenant
  }
}
