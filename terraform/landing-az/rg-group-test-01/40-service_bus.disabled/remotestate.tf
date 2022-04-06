terraform {
  backend "azurerm" {
    key = "az/group-test-01/service_bus/terraform.tfstate"
  }
}
