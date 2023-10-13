variable "idp_url" {
  description = "URL to the identity provider"
  type        = string
}

variable "organisation_name" {
  description = "Name of the organisation"
  type        = string
}

variable "users" {
  description = "List of users to create with associated metadata"
  type        = set(object({
    username       = string
    email          = string
    first_name     = string
    last_name      = string
    teams          = set(object({
      team_name    = string
      subteam_name = optional(string)
    }))
    gpg_public_key = string
  }))
  default = []
}
