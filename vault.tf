data "azurerm_client_config" "current" {}

resource "random_string" "passwd" {
  length  = 32
  lower   = true
  numeric = true
  special = true
  upper   = true
}

resource "random_string" "random" {
  length  = 12
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_key_vault" "main" {
  name                       = "vlt-ihvfcnyduevvctzssz"
  location                   = azurerm_resource_group.vmbuilder.location
  resource_group_name        = azurerm_resource_group.vmbuilder.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}

resource "azurerm_key_vault_secret" "rootpasswd" {
  name         = "passwd"
  value        = random_string.passwd.result
  key_vault_id = azurerm_key_vault.main.id
}
