terraform {
  backend "azurerm" {
    key = "az/group-test-01/storage_accounts/terraform.tfstate"
  }
}
