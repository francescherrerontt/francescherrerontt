data "terraform_remote_state" "global_rg" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    subscription_id      = var.subscription_id
    key                  = "csz/csz/shared/terraform.tfstate"
  }
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    subscription_id      = var.subscription_id
    key                  = "csz/csz/virtual_network/terraform.tfstate"
  }
}
