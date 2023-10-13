variable "organisation_name" {
  description = "Name of the organisation, this should be all-lowercase with no punctuation and no spaces"
  type        = string
}

variable "organisation_domain" {
  description = "Base domain of the organization"
  type        = string
}

variable "team_name" {
  description = "Name of the team"
  type        = string
}

variable "team_chunk" {
  description = "The chunk the team belongs to; used for distributing teams across multiple clusters in the same env"
  type        = number
}

variable "team_envs" {
  description = "Environments the team should support. Includes an optional domain override to override domain on a per-env basis."
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

# variable "vault_address" {
#   description = "URL to the vault instance to connect the service to"
#   type        = string
# }

variable "repository_domain" {
  description = "Domain of the repository host, e.g. github.com"
  type        = string
  default     = "github.com"

  validation {
    condition     = var.repository_domain == "github.com"
    error_message = "The only supported repository host is currently github.com"
  }
}

variable "repository_organisation_name" {
  description = "Name of the team's organisation in the repository host"
  type        = string
}

variable "repository_bot_name" {
  description = "Name of the team's repository bot"
  type        = string
}

variable "repository_bot_token" {
  description = "Personal access token for the bot that will be used by the team to manage CI operations"
  type        = string
  sensitive   = true
}

variable "repository_visibility" {
  description = "Set to \"public\" to make the team repository public"
  type        = string
  default     = "private"
}

variable "additional_deploy_keys" {
  description = "List of names of deploy keys that will be added to the team's repo on top of the default keys, along with a boolean value for each one determining if the deploy key should be read-write"
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
