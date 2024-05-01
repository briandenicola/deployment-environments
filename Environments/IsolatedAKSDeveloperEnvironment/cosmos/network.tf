resource "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_documents_azure_com" {
  name                  = "${var.cosmosdb_name}-link"
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_documents_azure_com.name
  resource_group_name   = data.azurerm_resource_group.this.name
  virtual_network_id    = var.virtual_network_id
}

resource "azurerm_private_endpoint" "cosmos_db" {
  name                = "${var.cosmosdb_name}-endpoint"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.cosmosdb_name}-endpoint"
    private_connection_resource_id = azurerm_cosmosdb_account.this.id
    subresource_names              = ["sql"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.privatelink_documents_azure_com.name
    private_dns_zone_ids = [ azurerm_private_dns_zone.privatelink_documents_azure_com.id ] 
  }
}



