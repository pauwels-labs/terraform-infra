services                  = [
  {
    "name"            = "homepage",
    "template_name"   = "",
    "repository_host" = "github",
  },
  {
    "name"                  = "redact-store",
    "template_name"         = "",
    "repository_host"       = "github",
    "repository_visibility" = "public"
  },
  {
    "name"                  = "redact-feed-api",
    "template_name"         = "",
    "repository_host"       = "github",
    "repository_visibility" = "public"
  },
  {
    "name"                  = "redact-feed-ui",
    "template_name"         = "",
    "repository_host"       = "github",
    "repository_visibility" = "public"
  },
  {
    "name"            = "redact-website",
    "template_name"   = "",
    "repository_host" = "github",
  }
]
org_name                  = "pauwels-labs"
tenant_name               = "main"
vault_address             = "https://secrets.pauwelslabs.com"
container_registry_domain = "274295908850.dkr.ecr.eu-west-1.amazonaws.com"
ci_webhook_domain         = "webhook.ci.pauwelslabs.com"
ecr_account_id            = "274295908850"
