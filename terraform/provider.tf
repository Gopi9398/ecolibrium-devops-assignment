### This file defines the Terraform configuration for the AWS provider, specifying the required version of Terraform and the AWS provider, as well as configuring the AWS provider with the specified region.###

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}