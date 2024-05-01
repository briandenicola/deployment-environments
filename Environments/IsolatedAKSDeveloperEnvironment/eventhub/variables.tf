variable "eventhub_namespace_name" {
  description = "The name of the Eventhub namespace"
}

variable "resource_group_name" {
  description = "The name of the resource group where Eventhub will be deployed"
}

variable "private_endpoint_subnet_id" {
  description = "The Azure subnet id where the Eventhub's private endpoint will be deployed"
}

variable "virtual_network_id" {
  description = "The Azure virtual network id where Eventhub's private endpoint will be deployed"
}
