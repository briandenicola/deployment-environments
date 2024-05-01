
resource "azurerm_private_dns_zone" "privatelink_azurecr_io" {
  name                      = "privatelink.azurecr.io"
  resource_group_name       = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_azurecr_io" {
  name                  = "${azurerm_virtual_network.this.name}-acr-link"
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_azurecr_io.name
  resource_group_name   = azurerm_resource_group.this.name
  virtual_network_id    = azurerm_virtual_network.this.id
}

resource "azurerm_private_dns_zone" "privatelink_vaultcore_azure_net" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_vaultcore_windows_net" {
  name                  = "${azurerm_virtual_network.this.name}-keyvault-link"
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_vaultcore_azure_net.name
  resource_group_name   = azurerm_resource_group.this.name
  virtual_network_id    = azurerm_virtual_network.this.id
}