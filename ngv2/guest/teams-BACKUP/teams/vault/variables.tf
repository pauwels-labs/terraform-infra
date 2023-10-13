variable "team_name" {
  description = "Name of the team to setup vault for"
  type        = string
}

variable "organisation_name" {
  description = "Name of the organisation, this should be all-lowercase with no punctuation and no spaces"
  type        = string
}

variable "root_organisation_name" {
  description = "Name of the root organisation hosting this organisation"
  type       = string
  nullable   = true
  default    = null
}

variable "environments" {
  description = "Name of isolated environments that this organisation is a part of; should not include the shared environment (e.g. should only be dev, staging, prod, etc.)"
  type        = set(object({
    name    = string
    is_prod = optional(bool, false)
  }))
  default     = []
}
