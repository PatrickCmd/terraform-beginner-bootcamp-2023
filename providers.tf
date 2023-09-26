terraform {
  cloud {
    organization = "PatrickCmdCloud"

    workspaces {
      name = "terra-house-cmd"
    }
  }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "random" {
  # Configuration options
}