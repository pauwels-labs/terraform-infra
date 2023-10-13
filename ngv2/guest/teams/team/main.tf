terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = ">= 5.25.0"
    }
    keycloak = {
      source = "mrparkers/keycloak"
      version = "4.3.1"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.15.2"
    }
  }
}
