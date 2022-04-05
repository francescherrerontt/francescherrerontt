terraform {
  backend "azurerm" {
    key = "#CWZ#/#RG#/service_bus/terraform.tfstate"
  }
}
