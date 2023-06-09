variable "org_name" {
  description = "Name of the organization in the repository host to create repositories in"
  type        = string
}

variable "org_domain" {
  description = "Domain of the organization hosting the tenants"
  type        = string
}

variable "tenants_by_chunk" {
  description = "All the tenants to add under the org, organized by chunk"
  type        = map(set(object({
    name           = string
    domain         = optional(string)
    repo_domain    = optional(string)
    repo_org_name  = optional(string)
    repo_bot_name  = optional(string)
    repo_bot_token = optional(string)
  })))
}

variable "vault_address" {
  description = "URL to the vault instance to connect the service to"
  type        = string
}

variable "repo_domain" {
  description = "Domain of the repository host (e.g. github.com)"
  type        = string
  default     = "github.com"

  validation {
    condition     = var.repo_domain == "github.com"
    error_message = "The only supported repository host is currently \"github.com\""
  }
}

variable "repo_bot_name" {
  description = "Name of the repository bot"
  type        = string
}

variable "repo_bot_token" {
  description = "Personal access token for the bot that will be used by the tenant to manage CI operations. This token is used if a tenant-specific one is not provided in the tenant object."
  type        = string
  sensitive   = true
}
