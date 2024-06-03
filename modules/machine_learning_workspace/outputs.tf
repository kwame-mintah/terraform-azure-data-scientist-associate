output "ml_workspace_id" {
  description = <<-EOF
    The ID of the Machine Learning Workspace.

EOF

  value = azurerm_machine_learning_workspace.ml_workspace.id
}

output "ml_workspace_discovery_url" {
  description = <<-EOF
    The url for the discovery service to identify regional endpoints for 
    machine learning experimentation services.

EOF

  value = azurerm_machine_learning_workspace.ml_workspace.discovery_url
}

output "ml_workspace_workspace_id" {
  description = <<-EOF
    The immutable id associated with this workspace.

EOF

  value = azurerm_machine_learning_workspace.ml_workspace.workspace_id
}
