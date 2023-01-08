include "root" {
	path = find_in_parent_folders()
}

include "terraform" {
	path = read_terragrunt_config(find_in_parent_folders("terraform.hcl"))
}

locals {
	env_vars 	 = read_terragrunt_config(find_in_parent_folders("env.hcl"))
	project_id 	 = local.env_vars.locals.project_id
	env 		 = local.env_vars.locals.environment
	env_short    = local.env_vars.locals.env_shortname
}

inputs = {
	project_id = local.project_id
	env 	   = local.env
	env_short  = local.env_short
	name 	   = "my_kms"
}