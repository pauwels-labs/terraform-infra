variable "idp_url" {
  description = "URL to the identity provider"
  type        = string
}

variable "organisation_name" {
  description = "Name of the organisation, this should be all-lowercase with no punctuation and no spaces"
  type        = string
}

variable "organisation_display_name" {
  description = "How to display the organisation name in the login UI"
  type        = string
  nullable    = true
  default     = null
}

variable "is_root" {
  description = "Set to true if this organisation is a root organisation that hosts other organisations"
  type        = bool
  default     = false
}

variable "root_organisation_name" {
  description = "Set to the name of the root organisation hosting this organisation if this is not a root organisation"
  type       = string
  nullable   = true
  default    = null
}

variable "is_guest" {
  description = "Set to true if this organisation is a guest organisation that hosts services on the ifnra of a root organisation; an organisation can be both"
  type        = bool
  default     = false
}

variable "environments" {
  description = "Name of isolated environments that this organisation is a part of; should not include the shared environment (e.g. should only be dev, staging, prod, etc.)"
  type        = set(object({
    name = string
  }))
  default     = []
}
