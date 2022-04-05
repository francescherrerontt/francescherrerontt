

resource "azurerm_shared_image_gallery" "packer" {
  name                = var.ntt_naming_convention ? lower(substr(format("sig%s%s%s", var.ntt_environment, replace(var.ntt_service_group, "/[-_.@=+<>:]/", ""), random_id.kv.hex), 0, 79)) : var.custom_sig_name
  resource_group_name = azurerm_resource_group.global.name
  location            = azurerm_resource_group.global.location
  description         = "Packer Shared Image Gallery"

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}

resource "azurerm_shared_image" "packer" {
  for_each = var.images

  name                = var.ntt_naming_convention ? lower(substr(format("img-%s-%s-%s", var.ntt_environment, replace(var.ntt_service_group, "/[_.@=+<>:]/", ""), each.value.name), 0, 79)) : var.custom_img_name
  gallery_name        = azurerm_shared_image_gallery.packer.name
  resource_group_name = azurerm_resource_group.global.name
  location            = azurerm_resource_group.global.location
  os_type             = each.value.os_type
  hyper_v_generation  = "V2"

  identifier {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
  }

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}
