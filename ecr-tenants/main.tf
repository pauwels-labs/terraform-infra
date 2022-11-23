terraform {
  backend "s3" {
    bucket = "terraform-backend-20210130214355088200000001"
    key = "ecr-tenants.tfstate"
    region = "eu-west-1"
    profile = "mfa"    
    role_arn = "arn:aws:iam::404672225309:role/TerraformBackend"    
    acl = "private"
    encrypt = true
    kms_key_id = "alias/terraform"
    workspace_key_prefix = "workspaces"
  }
}

provider "aws" {
  alias = "ecr"
  region = var.ecr_region
  profile = "mfa"  
  assume_role {
    role_arn = local.ecr_account_role_arn
  }  
}
