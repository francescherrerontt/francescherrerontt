terraform {
  backend "azurerm" {
    key = "az/group-test-01/app_service_plan/terraform.tfstate"
  }
}
