idp_url           = "https://identity.pauwelslabs.com"
vault_url         = "https://secrets.pauwelslabs.com"
organisation_name = "bitmantle"
is_root           = true
environments      = [
  {
    name               = "dev"
    oidc_discovery_url = "https://identity.pauwelslabs.com/realms/bitmantle-dev"
  },
  {
    name               = "staging"
    oidc_discovery_url = "https://identity.pauwelslabs.com/realms/bitmantle-staging"
  },
  {
    name               = "prod"
    oidc_discovery_url = "https://identity.pauwelslabs.com/realms/bitmantle-prod"
    true_admin_access  = true
  }
]
teams             = [
  {
    name = "main"
  }
]
