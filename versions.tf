terraform {
  # Due to the HashiCorp BSL License change, restricting the latest version of Terraform to 1.5.7.
  required_version = ">= 1.0.0, <= 1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.105.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
}
