terraform {
  backend "s3" {
    bucket = "terraform-backend-20210130214355088200000001"
    key = "eks.tfstate"
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
  alias = "cluster"
  region = var.cluster_region
  profile = "mfa"  
  assume_role {
    role_arn = local.cluster_account_role_arn
  }  
}

provider "aws" {
  alias = "keys"
  region = var.cluster_region
  profile = "mfa"  
  assume_role {
    role_arn = local.keys_account_role_arn
  }  
}
