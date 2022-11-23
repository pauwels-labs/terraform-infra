ecr_account_id               = "274295908850"
ecr_account_assume_role_name = "OrganizationAccountAccessRole"
ecr_region                   = "eu-west-1"
tenant_names                 = [
  "pauwels-labs-main"
]
oidc_url                     = "identity.pauwelslabs.com/realms/pauwels-labs-main"
oidc_thumbprint              = [
  "933c6ddee95c9c41a40f9f50493d82be03ad87bf"
]
audiences                    = {
  "azp": ["aws"],
  "aud": ["aws", "account"]
}
