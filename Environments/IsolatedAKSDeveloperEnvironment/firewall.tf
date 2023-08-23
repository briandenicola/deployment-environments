
resource "azurerm_public_ip" "firewall" {
  name                = local.fw_pip_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "this" {
  name                = local.fw_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  firewall_policy_id  = azurerm_firewall_policy.this.id
  sku_tier            = "Standard"
  sku_name            = "AZFW_VNet"

  ip_configuration {
    name                 = "confiugration"
    subnet_id            = azurerm_subnet.AzureFirewall.id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}
