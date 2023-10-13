idp_url                   = "https://identity.pauwelslabs.com"
organisation_name         = "bitmantle"
service_name              = "vault"
service_description       = "Provides login to the Vault instance which centrally manages all configurations and secrets"
environments = [
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
separate_clients_per_env  = false
