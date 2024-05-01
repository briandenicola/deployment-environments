terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~> 4"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

provider "azapi" {
}
