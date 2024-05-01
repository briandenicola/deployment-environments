resource "random_id" "this" {
  byte_length = 2
}

resource "random_pet" "this" {
  length    = 1
  separator = ""
}

resource "random_integer" "vnet_cidr" {
  min = 25
  max = 250
}

locals {
  location                = var.region
  resource_name           = "${random_pet.this.id}-${random_id.this.dec}"

  rg_name                 = "${local.resource_name}_app_rg"
  vnet_name               = "${local.resource_name}-app-network"
  aks_name                = "${local.resource_name}-aks"
  aks_node_rg_name        = "${local.resource_name}_k8s_nodes_rg"
  firewall_name           = "${local.resource_name}-fw"
  firewall_pip_name       = "${local.resource_name}-fw-pip"
  routetable_name         = "${local.resource_name}-routetable"
  cosmosdb_name           = "${local.resource_name}-db"
  eventhub_namespace_name = "${local.resource_name}-eventhub-namespace"
  bastion_name            = "${local.resource_name}-bastion"
  kv_name                 = "${local.resource_name}-kv"
  acr_account_name        = "${replace(local.resource_name, "-", "")}acr"

  vnet_cidr               = cidrsubnet("10.0.0.0/8", 8, random_integer.vnet_cidr.result)
  fw_subnet_cidr          = cidrsubnet(local.vnet_cidr, 8, 0)
  pe_subnet_cidir         = cidrsubnet(local.vnet_cidr, 8, 1)
  api_subnet_cidir        = cidrsubnet(local.vnet_cidr, 8, 2)
  nodes_subnet_cidir      = cidrsubnet(local.vnet_cidr, 8, 3)
  compute_subnet_cidir    = cidrsubnet(local.vnet_cidr, 8, 4)
  pls_subnet_cidir        = cidrsubnet(local.vnet_cidr, 8, 10)
  bastion_subnet_cidir    = cidrsubnet(local.vnet_cidr, 8, 250)
}

resource "azurerm_resource_group" "this" {
  name     = local.rg_name
  location = local.location

  tags = {
    Application = var.tags
    Components  = "AKS, Key Vault, Azure Firewall, CosmosDB, Event Hub, Bastion Host"
    DeployedOn  = timestamp()
  }
}
