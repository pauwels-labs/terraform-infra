terraform {
  backend "s3" {
    bucket = "terraform-backend-20210130214355088200000001"
    key = "templates.tfstate"
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
  }
}

provider "github" {
  owner = var.github_org_name
}
