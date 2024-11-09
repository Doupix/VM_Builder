resource "azurerm_shared_image_gallery" "main" {
  name                = "Gallery"
  resource_group_name = azurerm_resource_group.vmbuilder.name
  location            = azurerm_resource_group.vmbuilder.location
}

resource "azurerm_shared_image" "nginx" {
  name                = "nginx"
  gallery_name        = azurerm_shared_image_gallery.main.name
  resource_group_name = azurerm_resource_group.vmbuilder.name
  location            = azurerm_resource_group.vmbuilder.location
  os_type             = "Linux"

  identifier {
    publisher = "Doupix"
    offer     = "debian-12"
    sku       = "12"
  }
}
