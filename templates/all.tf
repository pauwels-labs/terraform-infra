module "rust_warp" {
  source = "./template"

  org_name = var.org_name
  name     = "rust-warp"
}

module "tenant" {
  source = "./template"

  org_name = var.org_name
  name     = "tenant"
}
