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

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.15.0-dev"
    }
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

provider "aws" {
  alias = "dns"
  region = var.cluster_region
  profile = "mfa"  
  assume_role {
    role_arn = local.dns_account_role_arn
  }  
}

provider "aws" {
  alias = "databases"
  region = var.cluster_region
  profile = "mfa"  
  assume_role {
    role_arn = local.databases_account_role_arn
  }  
}

provider "aws" {
  alias = "ecr"
  region = var.cluster_region
  profile = "mfa"  
  assume_role {
    role_arn = local.ecr_account_role_arn
  }  
}

provider "flux" {}

provider "kubectl" {}
