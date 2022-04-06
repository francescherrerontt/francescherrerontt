data "terraform_remote_state" "global_rg" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    subscription_id      = var.subscription_id
    key                  = "psz/psz/shared/terraform.tfstate"
  }
}

data "terraform_remote_state" "vnet_csz" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    subscription_id      = var.subscription_id
    key                  = "csz/csz/virtual_network/terraform.tfstate"
  }
}
