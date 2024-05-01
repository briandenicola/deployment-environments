resource "azurerm_private_dns_zone" "privatelink_servicebus_windows_net" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_servicebus_windows_net" {
  name                  = "${var.eventhub_namespace_name}-link"
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_servicebus_windows_net.name
  resource_group_name   = data.azurerm_resource_group.this.name
  virtual_network_id    = var.virtual_network_id
}

resource "azurerm_private_endpoint" "eventhub_namespace" {
  name                = "${var.eventhub_namespace_name}-endpoint"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.eventhub_namespace_name}-endpoint"
    private_connection_resource_id = azurerm_eventhub_namespace.this.id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.privatelink_servicebus_windows_net.name
    private_dns_zone_ids = [ azurerm_private_dns_zone.privatelink_servicebus_windows_net.id ]
  }
}



