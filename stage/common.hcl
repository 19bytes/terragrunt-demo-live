locals {
  # Expose the base source URL so different versions of the module can be deployed in different environments.
  base_source_url = "git::git@github.com:19bytes/terragrunt-demo.git//hcloud"
  source_git_ref = "hcloud-modules"
}