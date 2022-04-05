terraform {
  backend "azurerm" {
    key = "#CWZ#/#RG#/vm_scale_set/terraform.tfstate"
  }
}
