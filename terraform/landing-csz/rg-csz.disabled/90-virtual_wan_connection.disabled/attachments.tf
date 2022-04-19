data "terraform_remote_state" "virtual_network" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    subscription_id      = var.subscription_id
    key                  = "csz/csz/virtual_network/terraform.tfstate"
  }
}

data "terraform_remote_state" "global_virtual_wan" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    subscription_id      = var.subscription_id
    key                  = "global/virtual_wan/virtual_wan/terraform.tfstate"
  }
}