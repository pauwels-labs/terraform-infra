variable "idp_url" {
  description = "URL to the identity provider"
  type        = string
}

variable "root_organisation_name" {
  description = "Name of the root organisation the guest is being linked to"
  type        = string
}

variable "guest_organisation_name" {
  description = "Name of the organisation to link to the root realms"
  type        = string
}

variable "environments" {
  description = "Name of infrastructure environments to link the guest to"
  type        = set(object({
    name     = string
  }))
  default     = []
}

variable "services" {
  description = "Name of services and roles that this organisation should have access to"
  type        = set(object({
    name         = string
    shared       = optional(bool, false)
    roles        = optional(set(object({
      name = string
    })), [])
    environments = optional(set(object({
      name = string
    })), [])
  }))
  default     = []
}
