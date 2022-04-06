terraform {
  backend "azurerm" {
    key = "az/group-test-01/cosmos_db/terraform.tfstate"
  }
}
