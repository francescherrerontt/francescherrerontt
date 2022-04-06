terraform {
  required_version = ">=0.14.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.61.0"
    }
    random = {
      source = "hashicorp/random"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
}
provider "azurerm" {
  features {}
}
