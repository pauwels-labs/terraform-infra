idp_url           = "https://identity.pauwelslabs.com"
vault_url         = "https://secrets.pauwelslabs.com"
organisation_name = "bitmantle"
is_root           = true
is_guest          = false
environments      = [
  {
    name = "dev"
  },
  {
    name = "staging"
  },
  {
    name    = "prod"
    is_prod = true
  }
]
teams             = [
  {
    name = "main"
  }
]
