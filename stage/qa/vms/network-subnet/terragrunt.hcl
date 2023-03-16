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
    source = "${include.root.locals.base_source_url}/network-subnet?ref=${include.root.locals.source_git_ref}"
}

dependency "nw" {
  config_path = "../network"

  mock_outputs = {
    id = 123456789
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}


inputs = {
  network_id = dependency.nw.outputs.id
  subnetwork_ip_range = "10.0.1.0/24"
}