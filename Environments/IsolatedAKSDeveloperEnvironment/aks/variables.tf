variable "aks_name" {
  description = "The name of the Azure bastion host"
}

variable "resource_group_name" {
  description = "The name of the resource group where the bastion host will be deployed"
}

variable "aks_mgmt_subnet_id" {
  description = "The resource id of the subnet where the AKS API server will be deployed"
}

variable "aks_subnet_id" {
  description = "The Azure subnet id where the AKS cluster will be deployed"
}

variable "aks_vnet_id" {
  description = "The Azure virtual id where the AKS cluster will be deployed"
}

variable "acr_id" {
  description = "The Azure container registry id"
}

variable "log_analytics_workspace_id" {
  description = "The Azure Log Analytics workspace id"
}

variable "node_sku" {
  description = "The value for the VM SKU"
  default     = "Standard_D4ads_v5"
  validation {
    condition     = contains(["Standard_D4ads_v5", "Standard_B4s_v2", "Standard_A4m_v2", "Standard_D4s_v5"], var.node_sku)
    error_message = "Valid values for var: test_variable are (Standard_D4ads_v5, Standard_B4ms, Standard_A4m_v2, Standard_D4s_v5)."
  } 
}

variable "node_count" {
  description = "The value for the VM SKU"
  default     = 1
  validation {
    condition     = contains([1, 3, 6], var.node_count)
    error_message = "Valid values for var: test_variable are (1, 3, 6)."
  } 
}

variable "deploy_flux" {
  description = "Deploy Flux Extension"
  default     = false
}

variable "flux_repository" {
  description = "The repository for the Flux extension GitOps configuration"
  default     = "https://github.com/samples/flux-get-started"
}

variable "app_path" {
  description = "The app path within the Git repository for the Flux extension"
  default     = "./cluster-config"
}
