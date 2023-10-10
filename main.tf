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
  endpoint  = "http://localhost:4567/api"
  user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1"
  token     = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}


/*
module "terrahouse_aws" {
  source              = "./modules/terrahouse_aws"
  user_uuid           = var.user_uuid
  bucket_name         = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  # index_html_content = var.index_html_content
  content_version = var.content_version
  assets_path     = var.assets_path
}*/

resource "terratowns_home" "home" {
  name        = "How to play Need for Speed Games"
  description = <<DESCRIPTION
Welcome to the ultimate destination for Need for Speed enthusiasts! 
This is dedicated to celebrating and discussing the adrenaline-pumping 
racing games of the Need for Speed franchise, with a special focus on 
iconic titles like "Most Wanted," "Hot Pursuit," and "Rivals." 
Whether you're a seasoned street racer or just getting started, here you'll 
find insights, tips, and strategies on how to rise to the top and take on your rivals.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name     = "3fdq3gz.cloudfront.net"
  town            = "gamers-grotto"
  content_version = 1
}
