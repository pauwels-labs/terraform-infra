variable "org_name" {
  description = "Name of the organization owning the tenant"
  type        = string
}

variable "org_domain" {
  description = "Base domain of the organization owning the tenant"
  type        = string
}

variable "tenant_name" {
  description = "Name of the tenant"
  type        = string
}

variable "tenant_chunk" {
  description = "The chunk the tenant belongs to; used for distributing tenants across multiple clusters in the same env"
  type        = number
}

variable "tenant_domain" {
  description = "Domain specific to the tenant, where its services will be served"
  type        = string
}

variable "tenant_envs" {
  description = "Environments the tenant should support. Includes an optional domain override to override domain on a per-env basis."
  type        = list(object({
    name   = string,
    domain = optional(string)
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

variable "additional_hmac_tokens" {
  description = "List of additional HMAC tokens (other than the primary) to create"
  type        = set(string)
  default     = []
}

variable "vault_address" {
  description = "URL to the vault instance to connect the service to"
  type        = string
}

variable "tenant_repo_domain" {
  description = "Domain of the repository host, e.g. github.com"
  type        = string
  default     = "github.com"

  validation {
    condition     = var.tenant_repo_domain == "github.com"
    error_message = "The only supported repository host is currently github.com"
  }
}

variable "tenant_repo_org_name" {
  description = "Name of the tenant's organization in the repository host"
  type        = string
}

variable "tenant_repo_bot_name" {
  description = "Name of the tenant's repository bot"
  type        = string
}

variable "tenant_repo_bot_token" {
  description = "Personal access token for the bot that will be used by the tenant to manage CI operations"
  type        = string
  sensitive   = true
}

variable "tenant_repo_visibility" {
  description = "Set to \"public\" to make the tenant repository public"
  type        = string
  default     = "private"
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
