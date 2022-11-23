terraform {
  backend "s3" {
    bucket = "terraform-backend-20210130214355088200000001"
    key = "flux.tfstate"
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
      version = ">= 4.28.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.15.0-dev"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}

provider "flux" {}

provider "kubectl" {}

provider "github" {
  token = ""
  owner = var.github_org_name
}

data "terraform_remote_state" "eks" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
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

data "terraform_remote_state" "repositories" {
  backend   = "s3"
  workspace = "root"

  config = {
    bucket = "terraform-backend-20210130214355088200000001"
    key = "repositories.tfstate"
    region = "eu-west-1"
    profile = "mfa"    
    role_arn = "arn:aws:iam::404672225309:role/TerraformBackend"    
    acl = "private"
    encrypt = true
    kms_key_id = "alias/terraform"
    workspace_key_prefix = "workspaces"
  }
}
