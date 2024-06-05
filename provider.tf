# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy       = true
      purge_soft_deleted_keys_on_destroy = true
    }
    machine_learning {
      purge_soft_deleted_workspace_on_destroy = true
    }
    resource_group {
      # An action group named: 'Application Insights Smart Detection'
      # Is created, unsure where this is coming from? Force delete all resources.
      prevent_deletion_if_contains_resources = false
    }
  }
  tenant_id       = var.arm_tenant_id
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
  environment     = var.cloud_enviornment
}
