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

module "nodejs_express" {
  source = "./template"

  org_name = var.org_name
  name     = "nodejs-express"
}

module "golang_http" {
  source = "./template"

  org_name = var.org_name
  name     = "golang-http"
}

module "team" {
  source = "./template"

  org_name = var.org_name
  name     = "team"
}
