variable "organisation_name" {
  description = "Name of the organisation, this should be all-lowercase with no punctuation and no spaces"
  type        = string
}

variable "organisation_domain" {
  description = "Domain of the organization hosting the teams"
  type        = string
}

variable "teams_by_chunk" {
  description = "All the teams to add under the organisation, organized by chunk"
  type        = map(set(object({
    name                         = string
    domain                       = optional(string)
    repository_domain            = optional(string)
    repository_organisation_name = optional(string)
    repository_bot_name          = optional(string)
    repository_bot_token         = optional(string)
  })))
}

# variable "vault_address" {
#   description = "URL to the vault instance to connect the service to"
#   type        = string
# }

variable "repository_domain" {
  description = "Domain of the repository host (e.g. github.com)"
  type        = string
  default     = "github.com"

  validation {
    condition     = var.repository_domain == "github.com"
    error_message = "The only supported repository host is currently \"github.com\""
  }
}

variable "repository_organisation_name" {
  description = "Name of the organisation in the repository host"
  type        = string
}

variable "repository_bot_name" {
  description = "Name of the repository bot"
  type        = string
}

variable "repository_bot_token" {
  description = "Personal access token for the bot that will be used by the team to manage CI operations. This token is used if a team-specific one is not provided in the team object."
  type        = string
  sensitive   = true
}
