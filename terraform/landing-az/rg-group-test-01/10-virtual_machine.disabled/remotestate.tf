terraform {
  backend "azurerm" {
    key = "az/group-test-01/virtual_machine/terraform.tfstate"
  }
}
