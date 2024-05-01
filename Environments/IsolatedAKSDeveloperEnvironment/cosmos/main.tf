resource "azurerm_cosmosdb_account" "this" {
  name                      = var.cosmosdb_name
  resource_group_name       = data.azurerm_resource_group.this.name
  location                  = data.azurerm_resource_group.this.location
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  free_tier_enabled         = true

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = data.azurerm_resource_group.this.location
    failover_priority = 0
  }
}

