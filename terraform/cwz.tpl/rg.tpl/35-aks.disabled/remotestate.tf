terraform {
  backend "azurerm" {
    key = "#CWZ#/#RG#/aks/terraform.tfstate"
  }
}
