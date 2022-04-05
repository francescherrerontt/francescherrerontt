terraform {
  backend "azurerm" {
    key = "#CWZ#/#RG#/virtual_wan_connection/terraform.tfstate"
  }
}
