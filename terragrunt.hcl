terraform {
	source = ""
}


locals {
	common 					= read_terragrunt_config(find_in_parent_folders("common.hcl"))
	region 					= local.common.locals.gcp_region
	tf_state_project_id 	= local.common.locals.tf_state_project_id
}

## Definir el backend
generate "provider" {
	path = "provider.tf"
  	if_exists = "overwrite_terragrunt"
  	contents = << EOF
	terraform {
		required_providers {
			google = {
			source = "hashicorp/google"
			version = "4.47.0"
			}
		}
	}
		provider "google" {
		project     = local.tf_state_project_id
		region      = local.region
	}
	EOF
}

// Inyecta la configuración, pero espera que el bucket ya exista
generate "backend" {
	path = "backend.tf"
	if_exists = "overwrite_terragrunt"
	contents = << EOF
		terraform {
			backend "gcs" {
			bucket  = "terragunt_poc_states"
			prefix  = "${path_relative_to_include()}/terraform.tfstate"
 		}
	}
	EOF
}

// Crea el bucket si no existe
/*remote_state {
	backend = "gcs"
	generate = {
		path = "backend.tf"
		if_exists = "overwrite_terragrunt"
	}
	config = { 
		terraform {
		backend "gcs" {
			bucket  = "terragunt_poc_states"
			prefix  = "${path_relative_to_include()}/terraform.tfstate"
			project = local.tf_state_project_id
 			}
		}
	}
}*/

inputs = merge{
	local.common.locals,
	
}