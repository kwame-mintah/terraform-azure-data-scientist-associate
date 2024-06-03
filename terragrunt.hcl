locals {
  location = "West Europe"
  project_name = "dp-100"
}

#-------------------------------------------------------------------------------------------
# GLOBAL INPUTS
# These inputs apply to all terragrunt configurations in this subfolder. 
# There will be automatically merged into the child `terragrunt.hcl` using `include {}` block.
#-------------------------------------------------------------------------------------------
inputs = {
  location   = "${local.location}"
  project_name = "${local.project_name}"
}
