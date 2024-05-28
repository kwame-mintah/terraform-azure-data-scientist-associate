# (1) This block of code needs to be uncommented out first, before attempting to use the azurerm backend
# After all configurations have been populated run `terragrunt init -migrate-state` in the directory
# When prompted, answer yes and will copy the state file to the storage account.
# Alternatively follow this guide:
# https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli

terraform {
  backend "local" {}
}

# (2) Only uncomment out this code block, after the tfstate storage account has been created
# terraform {
#   backend "azurerm" {}
# }
