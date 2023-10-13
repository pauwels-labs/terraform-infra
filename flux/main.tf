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
      version = "5.26.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "0.25.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}

provider "flux" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
  git = {
    url   = "https://${var.repository_host_domain}/${var.org_name}/${var.repository_name}.git"
    http  = {
      username = "capt-haddock"
      password = "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"
    }
    # ssh = {
    #   username    = "git"
    #   private_key = tls_private_key.cd.private_key_pem
    # }
  }
}

provider "kubectl" {}

provider "github" {
  owner = var.org_name
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
