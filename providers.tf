terraform {
  cloud {
    organization = "PatrickCmdCloud"

    workspaces {
      name = "terra-house-cmd"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}