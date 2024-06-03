output "storage_account_name" {
  description = <<-EOF
    The name of the storage account created.

EOF

  value = azurerm_storage_account.storage.name
}

output "storage_account_key" {
  description = <<-EOF
    The primary access key for the storage account.

EOF

  value     = azurerm_storage_account.storage.primary_access_key
  sensitive = true
}

output "storage_container_name" {
  description = <<-EOF
    The name of the Container which should be created within 
    the Storage Account.

EOF

  value = azurerm_storage_container.storage.name
}
