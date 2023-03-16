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
    source = "${include.root.locals.base_source_url}/placement-group?ref=${include.root.locals.source_git_ref}"
}

inputs = {
  # placement_group_type = "spread"
  placement_group_name_prefix = "database"
  placement_group_name_suffix = "01"
}