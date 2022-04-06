terraform {
  backend "azurerm" {
    key = "az/group-test-01/aks/terraform.tfstate"
  }
}
