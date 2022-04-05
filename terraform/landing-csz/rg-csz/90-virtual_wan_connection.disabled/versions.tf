terraform {
  required_version = ">=0.14.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.61.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = data.terraform_remote_state.global_virtual_wan.outputs.subscription_id
}
