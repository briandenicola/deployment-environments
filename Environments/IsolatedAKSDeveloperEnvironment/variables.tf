variable "region" {
  description = "Region to deploy in Azure"
  default     = "southcentralus"
}

variable "vm_sku" {
  description = "The SKU for the default node pool"
  default     = "Standard_D4ads_v5" 
}

variable "ingress_namespace" {
  description = "The namespace where the Istio ingress will be deployed to"
  default     = "aks-istio-ingress"   
}

variable "github_repository" {
  description = "Git Repository used by flux"
  default = "https://github.com/briandenicola/deployment-environments"
}

variable "branch_name" {
  description = "Git branched used by flux"
  default     = "main"
} 

variable "deploy_cosmosdb" {
  description = "Deploy Azure Cosmos DB as part of this Sandbox"
  default     = false 
}

variable "deploy_eventhub" {
  description = "Deploy Azure Event Hub as part of this Sandbox"
  default     = false 
}
