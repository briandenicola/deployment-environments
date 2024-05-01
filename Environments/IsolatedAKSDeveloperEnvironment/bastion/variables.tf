variable "bastion_name" {
  description = "The name of the Azure bastion host"
}

variable "resource_group_name" {
  description = "The name of the resource group where the bastion host will be deployed"
}

variable "bastion_subnet_id" {
  description = "The Azure subnet id where the bastion host will be deployed"
}