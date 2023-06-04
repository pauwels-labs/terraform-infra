variable "org_name" {
  description = "Name of the organization owning the repository"
  type        = string
}

variable "tenant_name" {
  description = "Name of the tenant that will own the service"
  type        = string
}

variable "tenant_chunk" {
  description = "The chunk the tenant belongs to; used for distributing tenants across multiple clusters in the same env"
  type        = number
}

variable "tenant_repository_visibility" {
  description = "Set to \"public\" to make the tenant repository public"
  type        = string
  default     = "private"
}

variable "additional_hmac_tokens" {
  description = "List of additional HMAC tokens (other than the primary) to create"
  type        = set(string)
  default     = []
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
  description = "Personal access token for the GitHub bot that will be used by the tenant to manage CI operations"
  type        = string
  sensitive   = true
}

variable "additional_deploy_keys" {
  description = "List of names of deploy keys that will be added to the tenant's repo on top of the default keys, along with a boolean value for each one determining if the deploy key should be read-write"
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
