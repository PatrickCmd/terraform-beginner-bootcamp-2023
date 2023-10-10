terraform {
  # cloud {
  #   organization = "PatrickCmdCloud"

  #   workspaces {
  #     name = "terra-house-cmd"
  #   }
  # }

  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}

module "terrahouse_aws" {
  source              = "./modules/terrahouse_aws"
  user_uuid           = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  # index_html_content = var.index_html_content
  content_version = var.content_version
  assets_path     = var.assets_path
}

resource "terratowns_home" "home" {
  name            = "How to play Need for Speed Games"
  description     = <<DESCRIPTION
Welcome to the ultimate destination for Need for Speed enthusiasts! 
This is dedicated to celebrating and discussing the adrenaline-pumping 
racing games of the Need for Speed franchise, with a special focus on 
iconic titles like "Most Wanted," "Hot Pursuit," and "Rivals." 
Whether you're a seasoned street racer or just getting started, here you'll 
find insights, tips, and strategies on how to rise to the top and take on your rivals.
DESCRIPTION
  domain_name     = module.terrahouse_aws.cloudfront_url
  town            = "missingo"
  content_version = 1
}
