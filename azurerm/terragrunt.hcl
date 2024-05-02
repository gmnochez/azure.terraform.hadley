# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

locals {
  # Automatically load environment-level variables
  global_vars = read_terragrunt_config(find_in_parent_folders("global.hcl"))

  # Automatically load site-level variables
  env_vars = read_terragrunt_config(find_in_parent_folders("enviroment.hcl"))

# Automatically load resource variables
  res_vars = read_terragrunt_config("resource.hcl")




  # Extract the variables we need for easy access
  subscription_id                        = local.global_vars.locals.subscription_id
  client_id                              = local.global_vars.locals.client_id
  client_secret                          = local.global_vars.locals.client_secret
  tenant_id                              = local.global_vars.locals.tenant_id
  deployment_storage_resource_group_name = local.env_vars.locals.deployment_storage_resource_group_name
  deployment_storage_account_name        = local.env_vars.locals.deployment_storage_account_name
}

# Generate an Azure provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in an Blob Storage container
remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    subscription_id      = local.subscription_id
    resource_group_name  = local.deployment_storage_resource_group_name
    storage_account_name = local.deployment_storage_account_name
    container_name       = "terraform-state"
    key                  = "key_remote_state/terraform.tfstate"
  }
}

terraform {
  # Force Terraform to keep trying to acquire a lock for
  # up to 20 minutes if someone else already has the lock
  extra_arguments "retry_lock" {
    commands = get_terraform_commands_that_need_locking()

    arguments = [
      "-lock-timeout=20m"
    ]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.global_vars.locals,
  local.env_vars.locals,
  local.res_vars.locals,
  {
    client_secret = local.client_secret
  }
)
