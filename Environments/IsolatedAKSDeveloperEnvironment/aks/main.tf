resource "random_integer" "pod_cidr" {
  min = 100
  max = 127
}

resource "random_integer" "services_cidr" {
  min = 64
  max = 99
}

locals {
  aks_name         = var.aks_name
  aks_node_rg_name = "${local.aks_name}_nodes_rg"
  location         = data.azurerm_resource_group.this.location
}
