variable "cosmosdb_name" {
  description = "The name of the Azure Cosmos Database account"
}

variable "resource_group_name" {
  description = "The name of the resource group where Cosmosdb will be deployed"
}

variable "private_endpoint_subnet_id" {
  description = "The Azure subnet id where Cosmosdb's private endpoint will be deployed"
}

variable "virtual_network_id" {
  description = "The Azure virtual network id where Cosmosdb's private endpoint will be deployed"
}
