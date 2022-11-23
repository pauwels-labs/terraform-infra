variable "account_id" {
  description = "Account ID where the role to be assumed is located"  
  type = string
}

variable "role_name" {
  description = "Name of the role to be assumed"
  type = string
  default = "OrganizationAccountAccessRole"  
}
