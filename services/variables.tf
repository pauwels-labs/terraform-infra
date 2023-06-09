variable "org_domain" {
  description = "Base domain of the organization that's hosting the tenant"
  type        = string
}

variable "services" {
  description = "All the services to create for this tenant"
  type        = set(object({
    name             = string
    template_name    = optional(string)
    repo_visibility  = optional(string)
    domain           = optional(string)
    semver_range     = optional(string)
    envs             = optional(list(object({
      name         = string,
      domain       = optional(string)
      semver_range = optional(string)
    })))
  }))
  default     = []
}

variable "tenant_name" {
  description = "Name of the tenant in the organization that the services belong to"
  type        = string
}

variable "tenant_repo_domain" {
  description = "Domain of the repository host (e.g. github.com)"
  type        = string
  default     = "github.com"

  validation {
    condition     = var.tenant_repo_domain == "github.com"
    error_message = "The only supported repository host is currently \"github.com\""
  }
}

variable "tenant_repo_org_name" {
  description = "Name of the organization in the repository host to create repositories in"
  type        = string
}

variable "tenant_collapse_envs_to" {
  description = "If this is set to true, assume that all envs are stored in the specified environment cluster; this is useful when trying to save on costs and deployment separation is not critical, allowing you to have all environments in, for example, dev"
  type        = string
  nullable    = false
  default     = ""
}

variable "tenant_envs" {
  description = "Default environments the services should be deployed in. Includes an optional domain override to override domain on a per-env basis. These can be overriden for each individual service."
  type        = list(object({
    name         = string,
    domain       = optional(string),
    semver_range = optional(string)
  }))
  default     = [
    {
      name   = "dev"
    },
    {
      name   = "staging"
    },
    {
      name   = "prod"
    }
  ]
}

variable "vault_address" {
  description = "URL to the vault instance to connect the service to"
  type        = string
}

variable "container_registry_domain" {
  description = "The domain (without scheme or trailing slash) of the container registry where the service artifacts will be stored"
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
