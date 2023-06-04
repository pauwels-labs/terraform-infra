variable "org_name" {
  description = "Name of the organization in the repository host to create repositories in"
  type        = string
}

variable "tenants_by_chunk" {
  description = "All the tenants to add under the org, organized by chunk"
  type        = map(set(object({
    name                 = string
    repository_bot_host  = optional(string)
    repository_bot_name  = optional(string)
    repository_bot_token = optional(string)
  })))
}

variable "vault_address" {
  description = "URL to the vault instance to connect the service to"
  type        = string
}

variable "repository_bot_host" {
  description = "Repository host that the bot is a part of (e.g. github)"
  type        = string
  default     = "github"

  validation {
    condition     = var.repository_bot_host == "github"
    error_message = "The only supported repository host is currently github"
  }
}

variable "repository_bot_name" {
  description = "Name of the repository bot"
  type        = string
}

variable "repository_bot_token" {
  description = "Personal access token for the GitHub bot that will be used by the tenant to manage CI operations. This token is used if a tenant-specific one is not provided in the tenant object."
  type        = string
  sensitive   = true
}
