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

variable "is_root" {
  description = "Set to true if this organisation is a root organisation that hosts other organisations"
  type        = bool
  default     = false
}

variable "environments" {
  description = "List of isolated environments to configure"
  type        = set(object({
    name                 = string
    oidc_discovery_url   = string
    client_id            = optional(string)
    # If this is set to true, the admin role will also have access to global, non-environment
    # secrets such as repository SSH keys, HMAC tokens, bot tokens, and the base-layer of service
    # configs; otherwise, the admin role will be functionally equivalent to the writer role
    true_admin_access    = optional(bool, false)
    # If this is true, every role will be able to list every level of the organisation
    # hierarchy, but will only be able to read/write to the content they're permissioned to
    # do so with.
    # This allows users to browse through secrets like a folder hierarchy, rather than having
    # to type exactly the path they want to see. Set this to false to block users from being able
    # to, for example, see the list of teams and their names.
    allow_list_from_root = optional(bool, true)
  }))
  default     = []
}

variable "teams" {
  description = "List of isolated teams within the organisation that each deploy to all of the environments spanned by the organisation"
  type        = set(object({
    name = string
  }))
}
