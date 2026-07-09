terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "dimo-state-qa-s3"
    key          = "access-management.tfstate"
    region       = "ap-southeast-1"
    encrypt      = true
    profile      = "dimo-qa"
    use_lockfile = true
  }

}


provider "aws" {
  region = "ap-southeast-1"
  #profile = var.aws_profile

  default_tags {
    tags = {
      creator   = "sankhag-mit"
      project   = "dimo-qa"
      managedby = "terraform"
    }
  }

}

