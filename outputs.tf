output "service_principal_client_id" {
  description = <<-EOF
    The principal being used to apply terraform changes 
    for this subscription.

EOF

  value = data.azurerm_client_config.current.client_id
}

output "tenant_id" {
  description = <<-EOF
    The tenant ID used for this subscription.

EOF

  value = data.azurerm_client_config.current.tenant_id
}
