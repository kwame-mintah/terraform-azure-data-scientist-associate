# Create a Azure Machine Learning Workspace

resource "azurerm_application_insights" "ml_workspace_app_insights" {
  name                = "${var.name}-mlwrkspce-app-insights"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}

resource "azurerm_machine_learning_workspace" "ml_workspace" {
  #checkov:skip=CKV_AZURE_144:out of scope for this demostration.
  name                          = "${var.name}-mlwrkspc"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  application_insights_id       = azurerm_application_insights.ml_workspace_app_insights.id
  public_network_access_enabled = true
  key_vault_id                  = var.key_vault_id
  storage_account_id            = var.storage_account_id

  identity {
    type = "SystemAssigned"
  }

  tags = merge(
    var.tags
  )
}

resource "azurerm_machine_learning_compute_instance" "compute_instance" {
  name                          = substr("${var.name}-compute-instance", 0, 24)
  description                   = "A compute instance for workspace ${var.name}"
  machine_learning_workspace_id = azurerm_machine_learning_workspace.ml_workspace.id
  virtual_machine_size          = "STANDARD_DS11_V2" # Standard DSv2 Family Cluster Dedicated vCPUs

  identity {
    type = "SystemAssigned"
  }

  assign_to_user {
    object_id = var.assigned_user_object_id
    tenant_id = var.assigned_user_tenant_id
  }

  tags = merge(
    var.tags
  )
}

resource "azurerm_machine_learning_compute_cluster" "compute_cluster" {
  name                          = substr("${var.name}-computer-cluster", 0, 24)
  description                   = "A compute cluster for workspace ${var.name}"
  location                      = var.location
  vm_priority                   = "Dedicated"
  vm_size                       = "STANDARD_DS2_V2" # Standard DSv2 Family Cluster Dedicated vCPUs
  machine_learning_workspace_id = azurerm_machine_learning_workspace.ml_workspace.id
  local_auth_enabled            = false

  scale_settings {
    min_node_count                       = 0
    max_node_count                       = 2
    scale_down_nodes_after_idle_duration = "PT30S" # 30 seconds
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(
    var.tags
  )
}
