terraform {
  backend "azurerm" {
    key = "az/group-test-01/sql_server/terraform.tfstate"
  }
}
