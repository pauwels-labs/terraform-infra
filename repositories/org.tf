data "github_organization" "this" {
  name = var.github_org_name
}

resource "github_organization_settings" "this" {
  billing_email                 = "alex@bitmantle.com"
  blog                          = "https://bitmantle.com"
  default_repository_permission = "none"
  description                   = "Turn-key developer platforms"
  email                         = "alex@bitmantle.com"
  location                      = "Portugal"
  name                          = "bitmantle"
}

resource "github_membership" "ajpauwels" {
  username = "ajpauwels"
  role     = "admin"
}

resource "github_membership" "capt_haddock" {
  username = "capt-haddock"
  role     = "admin"
}
