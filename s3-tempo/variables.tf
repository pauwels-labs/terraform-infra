variable "bucket_region" {
  description = "Name of the region containing the S3 buckets"
  type        = string
}

variable "artifacts_account_assume_role_name" {
  description = "Name of the role to assume in the artifacts account"
  type        = string
  default     = "OrganizationAccountAccessRole"
}

variable "artifacts_account_id" {
  description = "ID of the account containing the S3 buckets"
  type        = string
}

variable "keys_account_assume_role_name" {
  description = "Name of the role to assume in the keys account"
  type        = string
  default     = "OrganizationAccountAccessRole"
}

variable "keys_account_id" {
  description = "ID of the account containing the KMS keys"
  type        = string
}

variable "authorized_role_arns" {
  description = "IAM role ARNs authorized to use these buckets (i.e. the mimir service accounts)"
  type        = list(string)
  default     = []
}
