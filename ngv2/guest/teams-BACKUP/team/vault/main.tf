terraform {
  required_providers {
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
