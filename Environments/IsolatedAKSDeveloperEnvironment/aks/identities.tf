resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = "${local.aks_name}-cluster-identity"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
}

resource "azurerm_user_assigned_identity" "aks_kubelet_identity" {
  name                = "${local.aks_name}-kubelet-identity"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
}