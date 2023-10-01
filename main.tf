terraform {
  # cloud {
  #   organization = "PatrickCmdCloud"

  #   workspaces {
  #     name = "terra-house-cmd"
  #   }
  # }
}

provider "aws" {
  region = "us-east-1"
}

module "terrahouse_aws" {
  source              = "./modules/terrahouse_aws"
  user_uuid           = var.user_uuid
  bucket_name         = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  # index_html_content = var.index_html_content
  content_version = var.content_version
  assets_path     = var.assets_path
}
