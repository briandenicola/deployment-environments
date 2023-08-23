
resource "azurerm_key_vault" "this" {
  name                        = local.kv_name
  resource_group_name         = azurerm_resource_group.this.name
  location                    = azurerm_resource_group.this.location
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
  enable_rbac_authorization   = true

  network_acls {
    bypass                    = "AzureServices"
    default_action            = "Deny"
  }


  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id 

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "List"
    ]
  }
}