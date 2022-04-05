terraform {
  backend "azurerm" {
    key = "#CWZ#/#RG#/app_service_plan/terraform.tfstate"
  }
}
