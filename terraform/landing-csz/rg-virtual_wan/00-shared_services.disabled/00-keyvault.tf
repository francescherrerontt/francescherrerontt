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
    "create",
    "decrypt",
    "delete",
    "encrypt",
    "get",
    "import",
    "list",
    "purge",
    "sign",
    "unwrapKey",
    "update",
    "verify",
    "wrapKey",
    "recover",
  ]

  secret_permissions = [
    "delete",
    "get",
    "list",
    "purge",
    "set",
    "recover",
  ]

  storage_permissions = [
    "get",
  ]
}
resource "azurerm_key_vault_access_policy" "readers_policy" {
  for_each = toset(var.reader_objects_ids)

  object_id    = each.value
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.global.id

  key_permissions = [
    "get",
    "list",
  ]

  secret_permissions = [
    "get",
    "list",
  ]

  certificate_permissions = [
    "get",
    "list",
  ]
}
resource "azurerm_key_vault_access_policy" "admin_policy" {
  for_each = toset(var.admin_objects_ids)

  object_id    = each.value
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.global.id

  key_permissions = [
    "backup",
    "create",
    "decrypt",
    "delete",
    "encrypt",
    "get",
    "import",
    "list",
    "purge",
    "recover",
    "restore",
    "sign",
    "unwrapKey",
    "update",
    "verify",
    "wrapKey",
  ]

  secret_permissions = [
    "backup",
    "delete",
    "get",
    "list",
    "purge",
    "recover",
    "restore",
    "set",
  ]

  certificate_permissions = [
    "backup",
    "create",
    "delete",
    "deleteissuers",
    "get",
    "getissuers",
    "import",
    "list",
    "listissuers",
    "managecontacts",
    "manageissuers",
    "purge",
    "recover",
    "restore",
    "setissuers",
    "update",
  ]
}

