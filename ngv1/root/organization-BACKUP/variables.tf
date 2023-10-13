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
  default     = ""
}

# variable "is_root" {
#   description = "Set to true if this organisation is a root organisation that hosts other organisations"
#   type        = bool
#   default     = false
# }

# variable "environments" {
#   description = "Name of isolated environments to configure"
#   type        = set(object({
#     name     = string
#     services = set(string)
#   }))
#   default     = []
# }

# variable "teams" {
#   description = "List of isolated teams within the organisation that each deploy to all of the environments spanned by the organisation"
#   type        = set(object({
#     name = string
#   }))
#   default     = []
# }

variable "services" {
  description = "List of services that a user can be permissioned to use"
  type        = set(object({
    name                                      = string
    description                               = string
    access_type                               = optional(string, "CONFIDENTIAL")
    standard_flow_enabled                     = optional(bool, false)
    implicit_flow_enabled                     = optional(bool, false)
    direct_access_grants_enabled              = optional(bool, false)
    service_accounts_enabled                  = optional(bool, false)
    oauth2_device_authorization_grant_enabled = optional(bool, false)
    backchannel_logout_session_required       = optional(bool, true)
    root_url                                  = optional(string)
    base_url                                  = optional(string)
    # The URIs provided in this array can specify "$${environment.name}" and it
    # will be replaced with the environment name
    valid_redirect_uris                       = optional(set(string))
  }))
  default     = []
}

# variable "users" {
#   description = "List of users to create with associated metadata"
#   type        = set(object({
#     username       = string
#     email          = string
#     first_name     = string
#     last_name      = string
#     gpg_public_key = string
#   }))
#   default = []
# }
