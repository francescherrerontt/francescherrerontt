data "azurerm_client_config" "current" {}

resource "random_id" "kv" {
  keepers = {
    rg_name = azurerm_resource_group.global.name
  }

  byte_length = 2
}

resource "azurerm_key_vault" "global" {
  name                        = var.ntt_naming_convention ? lower(format("kv%s%s%s", var.ntt_environment, substr(replace(var.ntt_service_group, "/[_.-]/", ""), 0, 15), random_id.kv.hex)) : var.custom_kv_name
  location                    = azurerm_resource_group.global.location
  resource_group_name         = azurerm_resource_group.global.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = merge(
    local.common_tags,
    var.resource_tags
  )

}

resource "azurerm_key_vault_access_policy" "terraform_policy" {

  object_id    = data.azurerm_client_config.current.object_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.global.id

  key_permissions = [
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
    "Recover",
  ]

  secret_permissions = [
    "Delete",
    "Get",
    "List",
    "Purge",
    "Set",
    "Recover",
  ]

  storage_permissions = [
    "Get",
  ]
}
resource "azurerm_key_vault_access_policy" "readers_policy" {
  for_each = toset(var.reader_objects_ids)

  object_id    = each.value
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.global.id

  key_permissions = [
    "Get",
    "List",
  ]

  secret_permissions = [
    "Get",
    "List",
  ]

  certificate_permissions = [
    "Get",
    "List",
  ]
}
resource "azurerm_key_vault_access_policy" "admin_policy" {
  for_each = toset(var.admin_objects_ids)

  object_id    = each.value
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.global.id

  key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]

  certificate_permissions = [
    "Backup",
    "Create",
    "Delete",
    "Deleteissuers",
    "Get",
    "Getissuers",
    "Import",
    "List",
    "Listissuers",
    "Managecontacts",
    "Manageissuers",
    "Purge",
    "Recover",
    "Restore",
    "Setissuers",
    "Update",
  ]
}

