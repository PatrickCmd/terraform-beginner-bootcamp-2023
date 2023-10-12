terraform {
  cloud {
    organization = "PatrickCmdCloud"

    workspaces {
      name = "terra-house-cmd"
    }
  }

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

module "home_nfs_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.nfs.public_path
  content_version = var.nfs.content_version
}

resource "terratowns_home" "home_nfs" {
  name            = "How to play Need for Speed Games"
  description     = <<DESCRIPTION
Welcome to the ultimate destination for Need for Speed enthusiasts! 
This is dedicated to celebrating and discussing the adrenaline-pumping 
racing games of the Need for Speed franchise, with a special focus on 
iconic titles like "Most Wanted," "Hot Pursuit," and "Rivals." 
Whether you're a seasoned street racer or just getting started, here you'll 
find insights, tips, and strategies on how to rise to the top and take on your rivals.
DESCRIPTION
  domain_name     = module.home_nfs_hosting.domain_name
  town            = "gamers-grotto"
  content_version = var.nfs.content_version
}

module "home_recipes_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.recipes.public_path
  content_version = var.recipes.content_version
}

resource "terratowns_home" "home_recipes" {
  name            = "Making Local Ugandan Rolex Recipe"
  description     = <<DESCRIPTION
A Ugandan Rolex is a popular street food in Uganda, made with eggs and chapati (a type of flatbread). 
It's a delicious and relatively simple dish to prepare. Here's a step-by-step guide on how to make a Ugandan Rolex:
DESCRIPTION
  domain_name     = module.home_recipes_hosting.domain_name
  town            = "missingo"
  content_version = var.recipes.content_version
}
