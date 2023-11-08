locals {
#   # Automatically load account-level variables
#   account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

#   # Automatically load region-level variables
#   region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Automatically load environment-level variables
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))

  base_source_url = local.common_vars.locals.base_source_url
  source_git_ref = local.common_vars.locals.source_git_ref
}

#remote_state {
#    backend = "azurerm"
#    generate = {
#        path = "backend.tf"
#        if_exists = "overwrite_terragrunt"
#    }
#    config = {
#        resource_group_name  = "terragruntdemo-rg"
#        storage_account_name = "terragruntdemostoracc"
#        container_name       = "terragruntdemostorcon"
#        key                  = "${path_relative_to_include()}/terraform.tfstate"
#    }
#}


remote_state {
  backend = "pg"
  generate = {
     path      = "backend.tf"
     if_exists = "overwrite_terragrunt"
  }
  config = {
    conn_str = "postgres://julian-paul.de/dcc?sslmode=disable"
    schema_name = "terraform_remote_state_${local.environment_vars.locals.environment}"
  }
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
terraform {
    required_providers {
        hcloud = {
            source = "hetznercloud/hcloud"
        }
    }
}

variable "hcloud_token" {
    default = ""
    sensitive = true
}
provider "hcloud" {
    token = var.hcloud_token
}
        EOF
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
#   local.account_vars.locals,
#   local.region_vars.locals,
  local.environment_vars.locals,
)
