terraform {
  required_providers {
    github = {
      source  = "integrations/github"
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
