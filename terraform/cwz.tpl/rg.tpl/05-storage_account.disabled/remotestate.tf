terraform {
  backend "azurerm" {
    key = "#CWZ#/#RG#/storage_accounts/terraform.tfstate"
  }
}
