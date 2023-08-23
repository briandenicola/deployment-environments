
resource "azurerm_firewall_policy" "this" {
  name                = "${local.fw_name}-policies"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Standard"

  dns {
    proxy_enabled = true
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "this" {
  name               = "${local.fw_name}_rules_collection"
  firewall_policy_id = azurerm_firewall_policy.this.id

  priority = 200

  application_rule_collection {
    name     = "app_rule_collection"
    priority = 500
    action   = "Allow"

    rule {
      name             = "mcr"
      source_addresses = ["*"]

      protocols {
        port = "443"
        type = "Https"
      }

      destination_fqdns = [
        "mcr.microsoft.com",
        "*.data.mcr.microsoft.com",
        "packages.microsoft.com",
        "acs-mirror.azureedge.net"
      ]
    }

    rule {
      name             = "management"
      source_addresses = ["*"]

      protocols {
        port = "443"
        type = "Https"
      }

      destination_fqdns = [
        "management.microsoft.com",
        "login.microsoftonline.com"
      ]
    }

    rule {
      name             = "docker"
      source_addresses = ["*"]

      protocols {
        port = "443"
        type = "Https"
      }

      destination_fqdns = [
        "*.docker.io",
        "production.cloudflare.docker.com"
      ]
    }

    rule {
      name             = "Monitoring"
      source_addresses = ["*"]

      protocols {
        port = "443"
        type = "Https"
      }

      destination_fqdns = [
        "dc.services.visualstudio.com",
        "*.ods.opinsights.azure.com",
        "*.oms.opinsights.azure.com",
        "*.monitoring.azure.com"
      ]
    }

    rule {
      name             = "Policy"
      source_addresses = ["*"]

      protocols {
        port = "443"
        type = "Https"
      }

      destination_fqdns = [
        "data.policy.core.windows.net",
        "store.policy.core.windows.net"
      ]
    }

    rule {
      name             = "Marketplace Extensions"
      source_addresses = ["*"]

      protocols {
        port = "443"
        type = "Https"
      }

      destination_fqdns = [
        "${local.location}.dp.kubernetesconfiguration.azure.com",
        "store.policy.core.windows.net",
        "arcmktplaceprod.azurecr.io",
        "marketplaceapi.microsoft.com",
        "*.ingestion.msftcloudes.com",
        "*.microsoftmetrics.com"
      ]
    }
  }
  
  network_rule_collection {
    name     = "network_rule_collection"
    priority = 400
    action   = "Allow"

    rule {
      name              = "monitor"
      source_addresses  = ["*"]
      destination_ports = ["443"]
      protocols         = ["TCP"]
      destination_addresses = [
        "AzureMonitor"
      ]
    }
  }
}

