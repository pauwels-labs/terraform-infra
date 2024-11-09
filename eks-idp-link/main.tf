terraform {
  backend "s3" {
    bucket               = "terraform-backend-20210130214355088200000001"
    key                  = "eks-idp-link.tfstate"
    region               = "eu-west-1"
    profile              = "mfa"
    role_arn             = "arn:aws:iam::404672225309:role/TerraformBackend"
    acl                  = "private"
    encrypt              = true
    kms_key_id           = "alias/terraform"
    workspace_key_prefix = "workspaces"
  }
  required_providers {}
}

provider "aws" {
  alias   = "cluster"
  region  = var.cluster_region
  profile = "mfa"
  assume_role {
    role_arn = local.cluster_account_role_arn
  }
}

data "terraform_remote_state" "eks" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    bucket               = "terraform-backend-20210130214355088200000001"
    key                  = "eks.tfstate"
    region               = var.remote_state_bucket_region
    profile              = "mfa"
    acl                  = "private"
    encrypt              = true
    kms_key_id           = "alias/terraform"
    workspace_key_prefix = "workspaces"
    assume_role          = {
      role_arn = "arn:aws:iam::404672225309:role/TerraformBackend"
    }
  }
}

data "terraform_remote_state" "idp" {
  backend   = "s3"
  workspace = var.organisation_name

  config = {
    bucket               = "terraform-backend-20210130214355088200000001"
    key                  = "idp.tfstate"
    region               = var.remote_state_bucket_region
    profile              = "mfa"
    acl                  = "private"
    encrypt              = true
    kms_key_id           = "alias/terraform"
    workspace_key_prefix = "workspaces"
    assume_role          = {
      role_arn = "arn:aws:iam::404672225309:role/TerraformBackend"
    }
  }
}
