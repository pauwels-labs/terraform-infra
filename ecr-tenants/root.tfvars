ecr_account_id               = "274295908850"
ecr_account_assume_role_name = "OrganizationAccountAccessRole"
ecr_region                   = "eu-west-1"
tenant_names                 = [
  "pauwels-labs-main"
]
oidc_url                     = "identity.pauwelslabs.com/realms/pauwels-labs-main"
oidc_thumbprint              = [
  "a053375bfe84e8b748782c7cee15827a6af5a405"
]
audiences                    = {
  "azp": ["aws"],
  "aud": ["aws", "account"]
}
