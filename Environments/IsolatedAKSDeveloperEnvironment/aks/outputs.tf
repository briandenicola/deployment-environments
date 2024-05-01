output "AKS_RESOURCE_GROUP" {
  value     = data.azurerm_resource_group.this.name
  sensitive = false
}

output "AKS_CLUSTER_NAME" {
  value     = local.aks_name
  sensitive = false
}

output "AKS_NODE_RESOURCE_GROUP" {
  value     = local.aks_node_rg_name
  sensitive = false
}