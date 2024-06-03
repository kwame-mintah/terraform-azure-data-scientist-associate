variable "name" {
  description = <<-EOF
    Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.
    
EOF

  type = string
}

variable "tags" {
  description = <<-EOF
    Tags to be added to resources created.
    
EOF

  type    = map(string)
  default = {}
}

variable "key_vault_id" {
  description = <<-EOF
    The ID of key vault associated with this Machine Learning Workspace.
    
EOF

  type = string
}

variable "storage_account_id" {
  description = <<-EOF
    The ID of the Storage Account associated with this Machine Learning Workspace.
    
EOF

  type = string
}

variable "resource_group_name" {
  description = <<-EOF
  The name of the resource group in which the Cognitive Service Account is created. 
  Changing this forces a new resource to be created.

EOF

  type = string
}

variable "location" {
  description = <<-EOF
  Specifies the supported Azure location where the resource exists. 
  Changing this forces a new resource to be created.

EOF

  type = string
}