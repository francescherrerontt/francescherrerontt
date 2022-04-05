terraform {
  backend "azurerm" {
    key = "#CWZ#/#RG#/load_balancer/terraform.tfstate"
  }
}
