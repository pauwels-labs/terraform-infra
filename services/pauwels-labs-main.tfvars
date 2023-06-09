services                  = [
  {
    "name"            = "homepage",
    "domain"          = "pauwelslabs.com"
  },
  {
    "name"            = "redact-store",
    "repo_visibility" = "public",
    "domain"          = "redact.ws",
    "semver_range"    = ">=1.0.0 <2.0.0"
    "envs"            = [
      {
        "name" = "dev"
      }
    ]
  },
  {
    "name"            = "redact-feed-api",
    "repo_visibility" = "public",
    "domain"          = "redact.ws",
    "envs"            = [
      {
        "name" = "dev"
      }
    ]
  },
  {
    "name"            = "redact-feed-ui",
    "repo_visibility" = "public",
    "domain"          = "redact.ws",
    "envs"            = [
      {
        "name" = "dev"
      }
    ]
  },
  {
    "name"   = "redact-website",
    "domain" = "redact.ws"
  },
  {
    "name"          = "nodejs-example",
    "template_name" = "nodejs-express",
    "domain"        = "pauwelslabs.com",
    "envs"            = [
      {
        "name" = "dev"
      }
    ]
  }
]
tenant_name               = "pauwels-labs-main"
tenant_repo_org_name      = "pauwels-labs"
tenant_collapse_envs_to   = "dev"
org_domain                = "pauwelslabs.com"
vault_address             = "https://secrets.pauwelslabs.com"
container_registry_domain = "274295908850.dkr.ecr.eu-west-1.amazonaws.com"
ecr_account_id            = "274295908850"
