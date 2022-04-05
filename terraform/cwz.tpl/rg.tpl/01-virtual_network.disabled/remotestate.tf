terraform {
  backend "azurerm" {
    key = "#CWZ#/#RG#/virtual_network/terraform.tfstate"
  }
}
