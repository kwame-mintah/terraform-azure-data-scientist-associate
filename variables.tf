variable "arm_client_id" {
  description = <<-EOF
  The Client ID which should be used. This can also be sourced 
  from the ARM_CLIENT_ID Environment Variable.

EOF

  type = string

}

variable "arm_client_secret" {
  description = <<-EOF
  The Client Secret which should be used. This can also be sourced 
  from the ARM_CLIENT_SECRET Environment Variable.

EOF

  type = string

}

variable "arm_tenant_id" {
  description = <<-EOF
  The Tenant ID which should be used. This can also be sourced 
  from the ARM_TENANT_ID Environment Variable.

EOF

  type = string

}

variable "arm_subscription_id" {
  description = <<-EOF
  The Subscription ID which should be used. This can also be sourced 
  from the ARM_SUBSCRIPTION_ID Environment Variable.

EOF

  type = string

}

variable "cloud_enviornment" {
  description = <<-EOF
  The Cloud Environment which should be used. Possible values are public,
  `usgovernment`, `german`, and `china`. Defaults to `public`. This can also be 
  sourced from the ARM_ENVIRONMENT Environment Variable.

EOF

  type    = string
  default = "public"

}

variable "create_tfstate_store" {
  description = <<-EOF
  Create a storage account to remotely store tfstate for the project. **NOTE**: requires
  local `.tfstate` to be migrated to remote, after storeage account has been created.

EOF

  type    = bool
  default = false
}

variable "environment" {
  description = <<-EOF
  The name of the _environment_ to help identify resources.

EOF

  type = string
}

variable "env_prefix" {
  description = <<-EOF
  The prefix added to resources in the environment.

EOF

  type = string
  validation {
    condition     = contains(["dev", "staging", "prod", "sandbox"], var.env_prefix)
    error_message = "The env_prefix value must be either: dev, staging, prod or sandbox."
  }
}

variable "location" {
  description = <<-EOF
  The Azure Region where the Resource Group should exist. 
  Changing this forces a new Resource Group to be created.

EOF

  type    = string
  default = "West Europe"
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

  type = string
}
