data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

data "http" "myip" {
  url = "http://checkip.amazonaws.com/"
}

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
  kv_name                 = "${local.resource_name}-kv"
  vnet_cidr               = cidrsubnet("10.0.0.0/8", 8, random_integer.vnet_cidr.result)
  fw_subnet_cidr          = cidrsubnet(local.vnet_cidr, 8, 0)
  pe_subnet_cidir         = cidrsubnet(local.vnet_cidr, 8, 1)
  api_subnet_cidir        = cidrsubnet(local.vnet_cidr, 8, 2)
  nodes_subnet_cidir      = cidrsubnet(local.vnet_cidr, 8, 3)
  compute_subnet_cidir    = cidrsubnet(local.vnet_cidr, 8, 4)
  pls_subnet_cidir        = cidrsubnet(local.vnet_cidr, 8, 10)
  bastion_subnet_cidir    = cidrsubnet(local.vnet_cidr, 8, 250)
  allowed_ip_range        = ["${chomp(data.http.myip.response_body)}"]
}

resource "azurerm_resource_group" "this" {
  name     = "${local.resource_name}_rg"
  location = local.location

  tags = {
    Application = "tbd"
    Components  = "tbd"
    DeployedOn  = timestamp()
  }
}
