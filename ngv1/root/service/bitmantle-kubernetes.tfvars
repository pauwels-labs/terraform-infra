idp_url                   = "https://identity.pauwelslabs.com"
organisation_name         = "bitmantle"
service_name              = "vault"
service_description       = "Provides OIDC login to the Kubernetes clusters in each environment"
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
separate_clients_per_env = true
