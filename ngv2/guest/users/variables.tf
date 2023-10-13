variable "idp_url" {
  description = "URL to the identity provider"
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

variable "users" {
  description = "List of users to create with associated metadata"
  type        = set(object({
    username       = string
    email          = string
    first_name     = string
    last_name      = string
    gpg_public_key = string
  }))
  default = []
}
