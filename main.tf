# Data source to access the configuration of the AzureRM provider.
data "azurerm_client_config" "current" {}

locals {
  common_tags = merge(
    var.tags
  )
}

#---------------------------------------------------
# Resource Group
#---------------------------------------------------
resource "azurerm_resource_group" "resource_group" {
  name     = "dp-100-${var.environment}-resources"
  location = var.location
  tags = merge(
    local.common_tags
  )
}

#---------------------------------------------------
# Storage Account(s)
#---------------------------------------------------
module "tfstate_storage" {
  count               = var.create_tfstate_store ? 1 : 0
  source              = "./modules/storage_account"
  name                = "tfstate${var.env_prefix}"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  personal_ip_address = [var.personal_ip_address]
  tags = merge(
    local.common_tags
  )
}

#trivy:ignore:AVD-AZU-0012
module "ml_workspace_storage" {
  source              = "./modules/storage_account"
  name                = "mlwrkspc${var.env_prefix}"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  personal_ip_address = [var.personal_ip_address]
  # Either put all resources on a virtual network or allow access from all network.
  # Choice needs to be made when creating compute resources etc. Virtual networking
  # OOO for demostrating, so allowing access from everywhere.
  #checkov:skip=CKV_AZURE_35:see comment above and in module `main.tf` L18
  network_acls_default_action = "Allow"
  tags = merge(
    local.common_tags
  )
}


#---------------------------------------------------
# Machine Learning Workspace(s)
#---------------------------------------------------
module "ml_workspace" {
  source                  = "./modules/machine_learning_workspace"
  name                    = "dp-100-${var.env_prefix}"
  resource_group_name     = azurerm_resource_group.resource_group.name
  location                = azurerm_resource_group.resource_group.location
  storage_account_id      = module.ml_workspace_storage.storage_account_id
  key_vault_id            = module.ml_workspace_storage.storage_key_vault_id
  assigned_user_object_id = "1239ac97-8ed6-4088-9670-14c8e238aed8" # This should be your own user object id within AAD, NOT the terraform client.
  assigned_user_tenant_id = data.azurerm_client_config.current.tenant_id
  tags = merge(
    local.common_tags
  )

  depends_on = [module.ml_workspace_storage]
}
