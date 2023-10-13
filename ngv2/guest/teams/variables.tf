variable "idp_url" {
  description = "URL to the identity provider"
  type        = string
}

variable "vault_url" {
  description = "URL to the vault instance to connect to"
  type        = string
}

variable "root_organisation_name" {
  description = "Set to the name of the root organisation hosting this organisation"
  type       = string
  nullable   = true
  default    = null
}

variable "root_organisation_domain" {
  description = "Base domain of the root organisation used to build things like webhook URLs"
  type        = string
}

variable "organisation_name" {
  description = "Name of the organisation, this should be all-lowercase with no punctuation and no spaces"
  type        = string
}

variable "teams" {
  description = "List of all the teams being created under the organisation"
  type        = set(object({
    name                       = string
    environments               = optional(set(object({
      name = string
    })), null)
    team_repository_domain     = optional(string, "github.com")
    team_repository_bot_name   = string
    team_repository_visibility = optional(string, "private")
    additional_hmac_tokens     = optional(set(string), [])
    additional_deploy_keys     = optional(set(object({
      name = string,
      rw   = bool
    })), [])
    known_hosts                = optional(string, <<EOT
github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
EOT
      )
  }))
  default     = []
}

variable "default_environments" {
  description = "The default set of environments a team is enabled in"
  type        = set(object({
    name = string
  }))
  default     = []
}
