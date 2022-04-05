terraform {
  backend "azurerm" {
    key = "#CWZ#/#RG#/virtual_machine/terraform.tfstate"
  }
}
