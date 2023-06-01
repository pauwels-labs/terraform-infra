terraform {
  backend "s3" {
    bucket = "terraform-backend-20210130214355088200000001"
    key = "s3-loki.tfstate"
    region = "eu-west-1"
    profile = "mfa"    
    role_arn = "arn:aws:iam::404672225309:role/TerraformBackend"    
    acl = "private"
    encrypt = true
    kms_key_id = "alias/terraform"
    workspace_key_prefix = "workspaces"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  alias = "artifacts"
  region = var.bucket_region
  profile = "mfa"  
  assume_role {
    role_arn = local.artifacts_account_role_arn
  }  
}

provider "aws" {
  alias = "keys"
  region = var.bucket_region
  profile = "mfa"  
  assume_role {
    role_arn = local.keys_account_role_arn
  }  
}
