terraform {
  backend "azurerm" {
    key = "#CWZ#/#RG#/sql_server/terraform.tfstate"
  }
}
