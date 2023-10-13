variable "idp_url" {
  description = "URL to the identity provider"
  type        = string
}

variable "organisation_name" {
  description = "Name of the organisation, this should be all-lowercase with no punctuation and no spaces"
  type        = string
}

variable "environments" {
  description = "Name of isolated environments to configure"
  type        = set(object({
    name = string
  }))
  default     = []
}

variable "separate_clients_per_env" {
  description = "Set this value to true to create separate OIDC clients per environment this service will be available in"
  type        = bool
  default     = false
}

variable "roles" {
  description = "List of roles that should be associated with this service"
  type        = set(object({
    name = string
  }))
  default     = []
}

variable "service_name" {
  description = "Name of the service"
  type        = string
}

variable "service_description" {
  description = "Short description of the service"
  type        = string
}

variable "oidc_client_config" {
  description = "Configuration parameters for the service's OIDC client"
  type        = object({
    access_type                               = optional(string, "CONFIDENTIAL")
    standard_flow_enabled                     = optional(bool, false)
    implicit_flow_enabled                     = optional(bool, false)
    direct_access_grants_enabled              = optional(bool, false)
    service_accounts_enabled                  = optional(bool, false)
    oauth2_device_authorization_grant_enabled = optional(bool, false)
    backchannel_logout_session_required       = optional(bool, true)
    root_url                                  = optional(string)
    base_url                                  = optional(string)
    valid_redirect_uris                       = optional(set(string))
  })
  default     = {}
}
