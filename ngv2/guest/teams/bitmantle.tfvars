idp_url                  = "https://identity.pauwelslabs.com"
vault_url                = "https://secrets.pauwelslabs.com"
root_organisation_name   = "bitmantle"
root_organisation_domain = "pauwelslabs.com"
organisation_name        = "bitmantle"
teams                    = [
  {
    name                     = "main"
    team_repository_bot_name = "capt-haddock"
  }
]
default_environments     = [
  {
    name = "dev"
  },
  {
    name = "staging"
  },
  {
    name = "prod"
  }
]
