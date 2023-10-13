data "github_organization" "this" {
  name = var.github_org_name
}

resource "github_organization_settings" "this" {
  billing_email                 = "alex@pauwelslabs.com"
  blog                          = "https://pauwelslabs.com"
  default_repository_permission = "none"
  description                   = "New technologies"
  email                         = "alex@pauwelslabs.com"
  location                      = "Portugal"
  name                          = "pauwels labs"
}

resource "github_membership" "ajpauwels" {
  username = "ajpauwels"
  role     = "admin"
}

resource "github_membership" "capt_haddock" {
  username = "capt-haddock"
  role     = "admin"
}

resource "github_membership" "howhelan" {
  username = "howhelan"
  role     = "member"
}

resource "github_membership" "costaneto" {
  username = "costaneto"
  role     = "member"
}
