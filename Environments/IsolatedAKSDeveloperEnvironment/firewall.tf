resource "azurerm_public_ip" "this" {
  name                = local.firewall_pip_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku                 = "Standard" 
}

resource azurerm_firewall this {
  name                = local.firewall_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  firewall_policy_id  = azurerm_firewall_policy.this.id
  sku_tier            = "Standard"
  sku_name            = "AZFW_VNet"

  ip_configuration {
    name                 = "standard"
    subnet_id            = azurerm_subnet.AzureFirewall.id
    public_ip_address_id = azurerm_public_ip.this.id
  }
}

resource azurerm_monitor_diagnostic_setting this {
  name                        = "diag"
  target_resource_id          = azurerm_firewall.this.id
  log_analytics_workspace_id  = azurerm_log_analytics_workspace.this.id

  enabled_log {
    category = "AzureFirewallApplicationRule"

  }

  enabled_log {
    category = "AzureFirewallNetworkRule"

  }

  enabled_log {
    category = "AzureFirewallDnsProxy"

  }

  metric {
    category = "AllMetrics"
  }
}