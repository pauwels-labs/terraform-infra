variable "idp_url" {
  description = "URL to the identity provider"
  type        = string
}

variable "vault_url" {
  description = "URL to the vault instance to connect to"
  type        = string
}

variable "organisation_name" {
  description = "Name of the organisation, this should be all-lowercase with no punctuation and no spaces"
  type        = string
}

variable "root_organisation_name" {
  description = "Set to the name of the root organisation hosting this organisation"
  type       = string
  nullable   = true
  default    = null
}

variable "environments" {
  description = "Name of isolated environments that this organisation deploys services to"
  type        = set(object({
    name     = string
  }))
  default     = []
}
