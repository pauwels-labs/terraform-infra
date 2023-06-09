variable "org_domain" {
  description = "Base domain of the organization that's hosting the tenant"
  type        = string
}

variable "tenant_name" {
  description = "Name of the tenant that will own the service"
  type        = string
}

variable "service_name" {
  description = "Name of the service to create"
  type        = string
}

variable "service_repo_domain" {
  description = "Domain of the repository host (e.g. github.com)"
  type        = string
  default     = "github.com"

  validation {
    condition     = var.service_repo_domain == "github.com"
    error_message = "The only supported repository host is currently \"github.com\""
  }
}

variable "service_repo_org_name" {
  description = "Name of the service's organization in the repository host"
  type        = string
}

variable "service_repo_visibility" {
  description = "Set to \"public\" to make the service repository public"
  type        = string
  default     = "private"
  nullable    = false
}

variable "service_domain" {
  description = "If the service will listen on a domain different than the default one for the tenant, specify it here"
  type        = string
  default     = ""
  nullable    = false
}

variable "service_semver_range" {
  description = "Acceptable semver range that the service may be in, e.g. >=0.0.0 <1.0.0"
  type        = string
  default     = ">=0.0.0 <1.0.0"
  nullable    = false
}

variable "service_envs" {
  description = "Environments the service should support. Includes an optional domain override to override domain on a per-env basis."
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
  nullable    = false
}

variable "template_name" {
  description = "Name of the template to inherit from"
  type        = string
  default     = ""
  nullable    = false
}

variable "additional_deploy_keys" {
  description = "List of names of deploy keys that will be added to the service's repo on top of the default keys, along with a boolean value for each one determining if the deploy key should be read-write"
  type        = list(object({
    name = string,
    rw   = bool,
  }))
  default     = []
}

variable "known_hosts" {
  description = "Content of known_hosts file for placing in the repository SSH configuration"
  type        = string
  default     = <<EOT
github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
EOT
}

variable "collapse_envs_to" {
  description = "If this is set to true, assume that all envs are stored in the specified environment cluster; this is useful when trying to save on costs and deployment separation is not critical, allowing you to have all environments in, for example, dev"
  type        = string
  nullable    = false
  default     = ""
}

variable "container_registry_domain" {
  description = "The domain of the container registry where the service artifacts will be stored"
  type        = string
}

variable "hmac_token_name" {
  description = "The HMAC token to use"
  type        = string
  default     = "primary"
}
