terraform {
  backend "azurerm" {
    key = "az/group-test-01/shared/terraform.tfstate"
  }
}
