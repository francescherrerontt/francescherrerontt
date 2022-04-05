terraform {
  required_version = ">=0.14.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.86.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  alias           = "csz"
  subscription_id = data.terraform_remote_state.vnet_csz.outputs.subscription_id
}
