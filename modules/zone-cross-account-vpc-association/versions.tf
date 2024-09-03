terraform {
  required_version = ">= 1.3.2"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 3.56"
      configuration_aliases = [aws.r53_owner, aws.vpc_owner]
    }
  }
}

provider "aws" {
  alias = "r53_owner"
}

provider "aws" {
  alias = "vpc_owner"
}
