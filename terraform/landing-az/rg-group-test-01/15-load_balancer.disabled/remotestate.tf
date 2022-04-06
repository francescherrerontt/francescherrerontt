terraform {
  backend "azurerm" {
    key = "az/group-test-01/load_balancer/terraform.tfstate"
  }
}
