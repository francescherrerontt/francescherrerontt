terraform {
  backend "azurerm" {
    key = "global/virtual_wan/virtual_wan/terraform.tfstate"
  }
}
