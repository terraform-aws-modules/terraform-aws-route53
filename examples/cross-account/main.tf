provider "aws" {
  region = local.region
}

provider "aws" {
  alias  = "external"
  region = local.region

  assume_role {
    role_arn     = var.external_account_role_arn
    session_name = "terraform-aws-route53-example"
  }
}

provider "aws" {
  alias  = "external_region"
  region = local.external_region

  assume_role {
    role_arn     = var.external_account_role_arn
    session_name = "terraform-aws-route53-example"
  }
}

data "aws_availability_zones" "available" {}

locals {
  region          = "eu-west-1"
  external_region = "us-east-1"

  name = "ex-${basename(path.cwd)}"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-route53"
  }
}

################################################################################
# Zone Account
################################################################################

module "zone" {
  source = "../.."

  name    = "terraform-aws-modules-example.com"
  comment = "Private zone for terraform-aws-modules example"

  # Ignore VPC after creation to avoid disruptive diff with associations
  ignore_vpc = true
  vpc = {
    default = {
      vpc_id     = module.vpc.vpc_id
      vpc_region = local.region
    }
  }

  vpc_association_authorizations = {
    external = {
      vpc_id     = module.vpc_external.vpc_id
      vpc_region = local.region
    }
    external_region = {
      vpc_id     = module.vpc_external_region.vpc_id
      vpc_region = local.external_region
    }
  }

  tags = local.tags
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]

  enable_nat_gateway = false

  tags = local.tags
}

################################################################################
# External Account
################################################################################

module "vpc_external" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  providers = {
    aws = aws.external
  }

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]

  enable_nat_gateway = false

  tags = local.tags
}

# Association (`aws_route53_zone_association`) must be performed by the account that owns the VPC.
# Association authorization (`aws_route53_vpc_association_authorization`) must be performed by the account that owns the zone.
# Hence why the `aws_route53_zone_association` resource is *outside* the scope of the module, but the authorization
# (`aws_route53_vpc_association_authorization`) is *inside* the scope of the module.
resource "aws_route53_zone_association" "external" {
  provider = aws.external

  zone_id    = module.zone.id
  vpc_id     = module.vpc_external.vpc_id
  vpc_region = local.region
}

################################################################################
# External Account - different region
################################################################################

data "aws_availability_zones" "external_region" {
  provider = aws.external_region
}

locals {
  ext_reg_azs = slice(data.aws_availability_zones.external_region.names, 0, 3)
}

module "vpc_external_region" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  providers = {
    aws = aws.external_region
  }

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.ext_reg_azs
  private_subnets = [for k, v in local.ext_reg_azs : cidrsubnet(local.vpc_cidr, 4, k)]

  enable_nat_gateway = false

  tags = local.tags
}

# Association (`aws_route53_zone_association`) must be performed by the account that owns the VPC.
# Association authorization (`aws_route53_vpc_association_authorization`) must be performed by the account that owns the zone.
# Hence why the `aws_route53_zone_association` resource is *outside* the scope of the module, but the authorization
# (`aws_route53_vpc_association_authorization`) is *inside* the scope of the module.
resource "aws_route53_zone_association" "external_region" {
  provider = aws.external_region

  zone_id    = module.zone.id
  vpc_id     = module.vpc_external_region.vpc_id
  vpc_region = local.external_region
}
