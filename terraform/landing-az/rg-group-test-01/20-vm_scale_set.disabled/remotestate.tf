terraform {
  backend "azurerm" {
    key = "az/group-test-01/vm_scale_set/terraform.tfstate"
  }
}
