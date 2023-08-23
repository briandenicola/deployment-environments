terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.66.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.3.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy = false
    }
    skip_provider_registration = true
  }
}

provider "azapi" {
}
