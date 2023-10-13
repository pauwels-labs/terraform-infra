variable "root_organisation_name" {
  description = "Set to the name of the root organisation hosting this organisation"
  type        = string
}

variable "root_organisation_domain" {
  description = "Base domain of the root organisation used to build things like webhook URLs"
  type        = string
}

variable "organisation_name" {
  description = "Name of the organisation, this should be all-lowercase with no punctuation and no spaces"
  type        = string
}

variable "team_name" {
  description = "Name of the team"
  type        = string
}

variable "environments" {
  description = "Name of isolated environments that this organisation deploys services to"
  type        = set(object({
    name = string
  }))
}

variable "team_repository_domain" {
  description = "Domain of the repository host, e.g. github.com"
  type        = string

  validation {
    condition     = var.team_repository_domain == "github.com"
    error_message = "The only supported repository host is currently github.com"
  }
}

variable "team_repository_bot_name" {
  description = "Name of the tenant's repository bot"
  type        = string
}

variable "team_repository_visibility" {
  description = "Set to \"public\" to make the tenant repository public"
  type        = string
}

variable "additional_hmac_tokens" {
  description = "List of additional HMAC tokens (other than the primary) to create"
  type        = set(string)
}

variable "additional_deploy_keys" {
  description = "List of names of deploy keys that will be added to the tenant's repo on top of the default keys, along with a boolean value for each one determining if the deploy key should be read-write"
  type        = list(object({
    name = string,
    rw   = bool,
  }))
}

variable "known_hosts" {
  description = "Content of known_hosts file for placing in the repository SSH configuration"
  type        = string
}
