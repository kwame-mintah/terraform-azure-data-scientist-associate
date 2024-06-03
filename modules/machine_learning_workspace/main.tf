# Create a Azure Machine Learning Workspace

resource "azurerm_application_insights" "ml_workspace_app_insights" {
  name                = "${var.name}-mlwrkspce-app-insights"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}

resource "azurerm_machine_learning_workspace" "ml_workspace" {
  #checkov:skip=CKV_AZURE_144:out of scope for this demostration.
  name                    = "${var.name}-mlwrkspc"
  location                = var.location
  resource_group_name     = var.resource_group_name
  application_insights_id = azurerm_application_insights.ml_workspace_app_insights.id
  key_vault_id            = var.key_vault_id
  storage_account_id      = var.storage_account_id

  identity {
    type = "SystemAssigned"
  }

  tags = merge(
    var.tags
  )
}
