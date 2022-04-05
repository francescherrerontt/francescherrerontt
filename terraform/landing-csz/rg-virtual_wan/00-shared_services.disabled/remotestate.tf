terraform {
  backend "azurerm" {
    key = "global/virtual_wan/shared/terraform.tfstate"
  }
}
