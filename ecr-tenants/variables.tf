variable "ecr_account_id" {
  description = "ID of the account containing the cluster ECR registry"
  type        = string
}

variable "ecr_account_assume_role_name" {
  description = "Name of the role to assume in the ECR account"
  type        = string
  default     = "OrganizationAccountAccessRole"
}

variable "ecr_region" {
  description = "Region of the ECR registry"
  type        = string
}

variable "tenant_names" {
  description = "Names of all the tenants to deploy"
  type        = set(string)
}

variable "oidc_url" {
  description = "OIDC endpoint for the identity provider without https:// or the /.well-known/openid-configuration component"
  type        = string
}

variable "oidc_thumbprint" {
  description = "Thumbprint of the signing authority certificate"
  type        = set(string)
}

variable "audiences" {
  description = "Audiences specified on tokens from this provider. Since we are using both the azp and aud claims, azp should contain just the client ID (e.g. 'aws') while aud should also contain this client ID, along with whatever audience keycloak uses for direct access grant credentials (i.e. 'account') so that the credential syncers can authenticate"
  type        = map(set(string))
  default     = {
    "azp": ["aws"],
    "aud": ["aws", "account"]
  }
}
