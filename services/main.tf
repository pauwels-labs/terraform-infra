terraform {
  backend "s3" {
    bucket = "terraform-backend-20210130214355088200000001"
    key = "services.tfstate"
    region = "eu-west-1"
    profile = "mfa"    
    role_arn = "arn:aws:iam::404672225309:role/TerraformBackend"    
    acl = "private"
    encrypt = true
    kms_key_id = "alias/terraform"
    workspace_key_prefix = "workspaces"
  }

  required_providers {
    github = {
      source = "integrations/github"
      version = ">= 5.25.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.15.2"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.0.1"
    }
  }
}

provider "github" {
  owner = var.org_name
}

provider "vault" {
  address = var.vault_address

  auth_login_oidc {
    role = "readwriter"
  }
}

provider "aws" {
  region = "eu-west-1"
  profile = "mfa"  
  assume_role {
    role_arn = "arn:aws:iam::${var.ecr_account_id}:role/${var.ecr_account_assume_role_name}"
  }  
}
