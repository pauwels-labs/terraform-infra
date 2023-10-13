variable "idp_url" {
  description = "URL to the identity provider"
  type        = string
}

variable "organisation_name" {
  description = "Name of the organisation"
  type        = string
}

variable "teams" {
  description = "List of teams to create along with subteams within it"
  type        = set(object({
    name     = string
    subteams = set(string)
  }))
  default = []
}
