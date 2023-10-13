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
