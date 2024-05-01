module "aks" {
  depends_on = [ 
    azurerm_subnet_route_table_association.api,
    azurerm_subnet_route_table_association.nodes,
  ]

  source                      = "./aks"
  aks_name                    = local.aks_name
  resource_group_name         = azurerm_resource_group.this.name
  aks_vnet_id                 = azurerm_virtual_network.this.id
  aks_subnet_id               = azurerm_subnet.nodes.id
  aks_mgmt_subnet_id          = azurerm_subnet.api.id
  acr_id                      = azurerm_container_registry.this.id
  log_analytics_workspace_id  = azurerm_log_analytics_workspace.this.id
  node_sku                    = var.node_sku
  node_count                  = var.node_count
  deploy_flux                 = var.deploy_flux
  flux_repository             = var.flux_repository
  
}

module "bastion" {
  count                       = var.deploy_bastion ? 1 : 0
  source                      = "./bastion"
  bastion_name                = local.bastion_name
  resource_group_name         = azurerm_resource_group.this.name
  bastion_subnet_id           = azurerm_subnet.bastion.id
}

module "cosmos" {
  count                       = var.deploy_cosmos_db ? 1 : 0
  source                      = "./cosmos"
  cosmosdb_name               = local.cosmosdb_name
  resource_group_name         =azurerm_resource_group.this.name
  private_endpoint_subnet_id  = azurerm_subnet.private-endpoints.id
  virtual_network_id          = azurerm_virtual_network.this.id
}

module "eventhub" {
  count                       = var.deploy_event_hub ? 1 : 0
  source                      = "./eventhub"
  eventhub_namespace_name     = local.eventhub_namespace_name
  resource_group_name         = azurerm_resource_group.this.name
  private_endpoint_subnet_id  = azurerm_subnet.private-endpoints.id
  virtual_network_id          = azurerm_virtual_network.this.id
}
