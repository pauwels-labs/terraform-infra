# variable "services_by_tenant" {
#   description = "Service name, template name, and repository host for all the services to create, organized by tenant"
#   type        = map(set(object({
#     name            = string
#     template_name   = string
#     repository_host = string
#   })))
#   default     = {}
# }

variable "services" {
  description = "Service name, template name, and repository host for all the services to create for the tenant in the org"
  type        = set(object({
    name            = string
    template_name   = string
    repository_host = string
  }))
  default     = []
}

variable "tenant_name" {
  description = "Name of the tenant in the organization that the services belong to"
  type        = string
}

variable "org_name" {
  description = "Name of the organization in the repository host to create repositories in"
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
