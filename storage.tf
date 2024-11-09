
resource "azurerm_storage_account" "terraform" {
  name                     = "storagehzvtevxyevcxyezjvz"
  resource_group_name      = azurerm_resource_group.vmbuilder.name
  location                 = azurerm_resource_group.vmbuilder.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "state" {
  name                  = "state"
  storage_account_name  = azurerm_storage_account.terraform.name
  container_access_type = "private"
}
