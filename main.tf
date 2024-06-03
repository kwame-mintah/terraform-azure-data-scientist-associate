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
  source              = "./modules/storage_account"
  name                = "tfstate${var.env_prefix}"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  personal_ip_address = [var.personal_ip_address]
  tags                = local.common_tags
}

module "ml_workspace_storage" {
  source              = "./modules/storage_account"
  name                = "mlwrkspc${var.env_prefix}"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  personal_ip_address = [var.personal_ip_address]
  tags                = local.common_tags
}


#---------------------------------------------------
# Machine Learning Workspace(s)
#---------------------------------------------------
module "ml_workspace" {
  source              = "./modules/machine_learning_workspace"
  name                = "dp-100-${var.env_prefix}"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  storage_account_id  = module.ml_workspace_storage.storage_account_id
  key_vault_id        = module.ml_workspace_storage.storage_key_vault_id
  tags                = local.common_tags

  depends_on = [module.ml_workspace_storage]
}
