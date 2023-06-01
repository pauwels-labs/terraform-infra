variable "github_org_name" {
  description = "Name of the GitHub organization to deploy the repository to"
  type        = string
}

variable "vault_address" {
  description = "URL to the vault instance to connect the service to"
  type        = string
}

variable "container_registry_domain" {
  description = "The domain (without scheme or trailing slash) of the container registry where the service artifacts will be stored"
  type        = string
}

variable "ci_webhook_domain" {
  description = "The domain (without scheme or trailing slash) of the CI webhook"
  type        = string
}

variable "ecr_account_id" {
  description = "ID of the account containing the cluster ECR registry"
  type        = string
  default     = ""
}

variable "ecr_account_assume_role_name" {
  description = "Name of the role to assume in the ECR account"
  type        = string
  default     = "OrganizationAccountAccessRole"
}
