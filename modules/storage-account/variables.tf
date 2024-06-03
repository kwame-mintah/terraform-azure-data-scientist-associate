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

variable "personal_ip_address" {
  description = <<-EOF
    Add your client IP address to the storage account
    
EOF

  type = list(string)
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