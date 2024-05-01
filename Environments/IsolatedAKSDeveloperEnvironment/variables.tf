variable "region" {
  description = "Region to deploy in Azure"
  default     = "southcentralus"
}

variable "tags" {
  description = "Tags to apply to all resources"
  default     = "Deployment Environment Demo"
}

variable "node_sku" {
  description = "The value for the VM SKU"
  default     = "Standard_D4ads_v5"
}

variable "node_count" {
  description = "The value for the VM SKU"
  default     = 1
}

variable "deploy_bastion" {
  description = "Deploy a bastion host"
  default     = true
}

variable "deploy_event_hub" {
  description = "Deploy an Event Hub namespace"
  default     = false
}

variable "deploy_cosmos_db" {
  description = "Deploy a Cosmos DB instance"
  default     = false
}

variable "deploy_flux" {
  description = "Deploy Flux Extension"
  default     = true
}

variable "flux_repository" {
  description = "The repository for the Flux extension GitOps configuration"
  default     = "https://github.com/samples/flux-get-started"
}
