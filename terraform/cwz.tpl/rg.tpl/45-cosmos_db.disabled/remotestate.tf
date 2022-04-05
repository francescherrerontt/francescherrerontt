terraform {
  backend "azurerm" {
    key = "#CWZ#/#RG#/cosmos_db/terraform.tfstate"
  }
}
