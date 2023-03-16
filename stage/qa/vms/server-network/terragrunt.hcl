# ---------------------------------------------------------------------------------------------------------------------
# Include configurations that are common used across multiple environments.
# ---------------------------------------------------------------------------------------------------------------------

# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "${include.root.locals.base_source_url}/server-network?ref=${include.root.locals.source_git_ref}"
}

dependency "server" {
  config_path = "../server"

  mock_outputs = {
    id = 123456789
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

dependency "subnet" {
  config_path = "../network-subnet"

  mock_outputs = {
    id = 123456789
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

inputs = {
  srvnetwork_server_id = dependency.server.outputs.id
  srvnetwork_subnet_id = dependency.subnet.outputs.id
}