# Create Azure Storage for Terraform
data "azurerm_client_config" "current" {}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storage" {
  name                            = "${var.name}${random_string.resource_code.result}"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = true # Ideally this would be false, however needs a VNET to be created.
  enable_https_traffic_only       = true
  allow_nested_items_to_be_public = false
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }
  network_rules {
    default_action = "Deny"
    bypass         = ["Metrics", "AzureServices"]
    ip_rules       = var.personal_ip_address # Should be your own IP address, or won't be able to apply changes.
  }
  queue_properties {
    hour_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
    minute_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      customer_managed_key
    ]
  }

  tags = merge(
    var.tags
  )
}

resource "azurerm_storage_container" "storage" {
  name                  = "${var.name}-storage"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

# Customer Managed Key (CMK) for storage

resource "azurerm_key_vault" "storage_key_vault" {
  name                          = substr("${var.name}-key-vault-cmk", 0, 24)
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = "standard"
  soft_delete_retention_days    = 7
  purge_protection_enabled      = true
  public_network_access_enabled = false
  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = var.personal_ip_address # Should be your own IP address, or won't be able to apply changes.
  }

  tags = merge(
    var.tags
  )
}

resource "azurerm_key_vault_access_policy" "storage_storage" {
  key_vault_id = azurerm_key_vault.storage_key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_storage_account.storage.identity[0].principal_id

  secret_permissions = ["Get"]
  key_permissions = [
    "Get",
    "UnwrapKey",
    "WrapKey"
  ]
}

resource "azurerm_key_vault_key" "storage_key_vault_key" {
  name            = substr("${var.name}-vault-key", 0, 24)
  key_vault_id    = azurerm_key_vault.storage_key_vault.id
  key_type        = "RSA"
  key_size        = 2048
  key_opts        = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  expiration_date = "2024-12-31T00:00:00Z"
  tags = merge(
    var.tags
  )

  depends_on = [
    azurerm_key_vault.storage_key_vault
  ]
}

resource "azurerm_storage_account_customer_managed_key" "storage_cmk" {
  storage_account_id = azurerm_storage_account.storage.id
  key_vault_id       = azurerm_key_vault.storage_key_vault.id
  key_name           = azurerm_key_vault_key.storage_key_vault_key.name
}

# Storage account logging for blobs

resource "azurerm_log_analytics_workspace" "storage_analytics_workspace" {
  name                = "${var.name}-analystics-workspace"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = merge(
    var.tags
  )
}

resource "azurerm_log_analytics_storage_insights" "storage_analytics_storage_insights" {
  name                = "${var.name}-storage-insight-config"
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.storage_analytics_workspace.id
  storage_account_id  = azurerm_storage_account.storage.id
  storage_account_key = azurerm_storage_account.storage.primary_access_key
}

# Diagnostic setting for storage account

resource "azurerm_monitor_diagnostic_setting" "storage_diagnostic_setting" {
  name                       = "${var.name}-diagnostic-setting"
  target_resource_id         = azurerm_storage_account.storage.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.storage_analytics_workspace.id

  metric {
    category = "Transaction"
  }

  depends_on = [azurerm_log_analytics_workspace.storage_analytics_workspace]
}
