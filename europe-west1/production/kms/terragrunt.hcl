include "root" {
	path = find_in_parent_folders()
}

include "terraform" {
	path = find_in_parent_folders("terraform.hcl")
}

locals {
	env_vars 	 = read_terragrunt_config(find_in_parent_folders("env.hcl"))
	common_vars  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
	project_id 	 = local.env_vars.locals.project_id
	env 		 = local.env_vars.locals.environment
	env_short    = local.env_vars.locals.env_shortname
	project     = local.common_vars.locals.tf_state_project_id
	region      = local.common_vars.locals.gcp_region
	
	
}


inputs = {
	project_id = local.project_id
	env 	   = local.env
	env_short  = local.env_short
	name 	   = "my_kms"
	project     = local.common_vars.locals.tf_state_project_id
	region      = local.common_vars.locals.gcp_region
}