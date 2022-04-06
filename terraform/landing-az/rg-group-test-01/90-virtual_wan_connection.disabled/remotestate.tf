terraform {
  backend "azurerm" {
    key = "az/group-test-01/virtual_wan_connection/terraform.tfstate"
  }
}
