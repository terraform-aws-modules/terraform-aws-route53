provider "aws" {
  region = "eu-west-1"
}

locals {
  zone_name = sort(keys(module.zones.route53_zone_zone_id))[0]
  #  zone_id = module.zones.route53_zone_zone_id["terraform-aws-modules-example.com"]

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
}

module "zones" {
  source = "../../modules/zones"

  zones = {
    "terraform-aws-modules-example.com" = {
      comment = "terraform-aws-modules-example.com (production)"
      tags = {
        Name = "terraform-aws-modules-example.com"
      }
    }

    "app.terraform-aws-modules-example.com" = {
      comment           = "app.terraform-aws-modules-example.com"
      delegation_set_id = module.delegation_sets.route53_delegation_set_id.main
      tags = {
        Name = "app.terraform-aws-modules-example.com"
      }
    }

    "private-vpc.terraform-aws-modules-example.com" = {
      # in case than private and public zones with the same domain name
      domain_name = "terraform-aws-modules-example.com"
      comment     = "private-vpc.terraform-aws-modules-example.com"
      vpc = [
        {
          vpc_id = module.vpc1.vpc_id
        },
        {
          vpc_id = module.vpc2.vpc_id
        },
      ]
      tags = {
        Name = "private-vpc.terraform-aws-modules-example.com"
      }
    }
  }

  tags = {
    ManagedBy = "Terraform"
  }
}

module "records" {
  source = "../../modules/records"

  zone_name = local.zone_name
  #  zone_id = local.zone_id

  records = [
    {
      name = ""
      type = "A"
      ttl  = 3600
      records = [
        "10.10.10.10",
      ]
    },
    {
      key  = "s3-bucket"
      name = "s3-bucket-${module.s3_bucket.s3_bucket_hosted_zone_id}"
      type = "A"
      alias = {
        name    = module.s3_bucket.s3_bucket_website_domain
        zone_id = module.s3_bucket.s3_bucket_hosted_zone_id
      }
    },
    {
      name           = "geo"
      type           = "CNAME"
      ttl            = 5
      records        = ["europe.test.example.com."]
      set_identifier = "europe"
      geolocation_routing_policy = {
        continent = "EU"
      }
    },
    {
      name           = "geoproximity-aws-region"
      type           = "CNAME"
      ttl            = 5
      records        = ["us-east-1.test.example.com."]
      set_identifier = "us-east-1-region"
      geoproximity_routing_policy = {
        aws_region = "us-east-1"
        bias       = 0
      }
    },
    {
      name           = "geoproximity-coordinates"
      type           = "CNAME"
      ttl            = 5
      records        = ["nyc.test.example.com."]
      set_identifier = "nyc"
      geoproximity_routing_policy = {
        coordinates = {
          latitude  = "40.71"
          longitude = "-74.01"
        }
      }
    },
    {
      name = "cloudfront"
      type = "A"
      alias = {
        name    = module.cloudfront.cloudfront_distribution_domain_name
        zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
      }
    },
    {
      name = "cloudfront"
      type = "AAAA"
      alias = {
        name    = module.cloudfront.cloudfront_distribution_domain_name
        zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
      }
    },
    {
      name           = "test"
      type           = "CNAME"
      ttl            = 5
      records        = ["test.example.com."]
      set_identifier = "test-primary"
      weighted_routing_policy = {
        weight = 90
      }
    },
    {
      name           = "test"
      type           = "CNAME"
      ttl            = 5
      records        = ["test2.example.com."]
      set_identifier = "test-secondary"
      weighted_routing_policy = {
        weight = 10
      }
    },
    {
      name            = "failover-primary"
      type            = "A"
      set_identifier  = "failover-primary"
      health_check_id = aws_route53_health_check.failover.id
      alias = {
        name    = module.cloudfront.cloudfront_distribution_domain_name
        zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
      }
      failover_routing_policy = {
        type = "PRIMARY"
      }
    },
    {
      name           = "failover-secondary"
      type           = "A"
      set_identifier = "failover-secondary"
      alias = {
        name    = module.s3_bucket.s3_bucket_website_domain
        zone_id = module.s3_bucket.s3_bucket_hosted_zone_id
      }
      failover_routing_policy = {
        type = "SECONDARY"
      }
    },
    {
      name           = "latency-test"
      type           = "A"
      set_identifier = "latency-test"
      alias = {
        name                   = module.cloudfront.cloudfront_distribution_domain_name
        zone_id                = module.cloudfront.cloudfront_distribution_hosted_zone_id
        evaluate_target_health = true
      }
      latency_routing_policy = {
        region = "eu-west-1"
      }
    }
  ]

  depends_on = [module.zones]
}

module "terragrunt" {
  source = "../../modules/records"

  zone_name = local.zone_name

  # Terragrunt has a bug (https://github.com/gruntwork-io/terragrunt/issues/1211) that requires `records` to be wrapped with `jsonencode()`
  records_jsonencoded = jsonencode([
    {
      key  = "new A"
      name = "new"
      type = "A"
      ttl  = 3600
      records = [
        "10.10.10.10",
      ]
    },
    {
      name = "new2"
      type = "A"
      ttl  = 3600
      records = [
        "10.10.10.11",
        "10.10.10.12",
      ]
    },
    {
      name = "s3-bucket-terragrunt"
      type = "A"
      alias = {
        # In Terragrunt code the values may depend on the outputs of modules:
        # name    = dependency.s3_bucket.outputs.s3_bucket_website_domain
        # zone_id = dependency.s3_bucket.outputs.s3_bucket_hosted_zone_id
        # Terragrunt passes known values to the module:
        name    = "s3-website-eu-west-1.amazonaws.com"
        zone_id = "Z1BKCTXD74EZPE"
      }
    }
  ])

  depends_on = [module.zones]
}

module "records_with_full_names" {
  source = "../../modules/records"

  zone_name = local.zone_name

  records = [
    {
      name               = "with-full-name-override.${local.zone_name}"
      full_name_override = true
      type               = "A"
      ttl                = 3600
      records = [
        "10.10.10.10",
      ]
    },
    {
      name = "web"
      type = "A"
      ttl  = 3600
      records = [
        "10.10.10.11",
        "10.10.10.12",
      ]
    },
  ]

  depends_on = [module.zones]
}

module "delegation_sets" {
  source = "../../modules/delegation-sets"

  delegation_sets = {
    main = {}
  }
}

module "resolver_rule_associations" {
  source = "../../modules/resolver-rule-associations"

  vpc_id = module.vpc1.vpc_id

  resolver_rule_associations = {
    example = {
      resolver_rule_id = aws_route53_resolver_rule.sys.id
    },
    example2 = {
      name             = "example2"
      resolver_rule_id = aws_route53_resolver_rule.sys.id
      vpc_id           = module.vpc2.vpc_id
    },
  }
}

module "resolver_endpoints" {
  source = "../../modules/resolver-endpoints"

  name       = "example1"
  direction  = "INBOUND"
  protocols  = ["Do53", "DoH"]
  subnet_ids = module.vpc1.private_subnets

  vpc_id                     = module.vpc1.vpc_id
  security_group_name_prefix = "example1-sg-"
  security_group_ingress_cidr_blocks = [
    module.vpc2.vpc_cidr_block
  ]
}

###################
# Disabled modules
###################

module "disabled_resolver_endpoints" {
  source = "../../modules/resolver-endpoints"

  create = false
}

module "disabled_records" {
  source = "../../modules/records"

  create = false
}

#########
# Extras - should be created in advance
#########

resource "aws_route53_health_check" "failover" {
  fqdn              = module.cloudfront.cloudfront_distribution_domain_name
  port              = 443
  type              = "HTTPS"
  resource_path     = "/index.html"
  failure_threshold = 3
  request_interval  = 30
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket_prefix = "s3-bucket-"
  force_destroy = true

  website = {
    index_document = "index.html"
  }
}

module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "~> 3.0"

  enabled             = true
  wait_for_deployment = false

  origin = {
    s3_bucket = {
      domain_name = module.s3_bucket.s3_bucket_bucket_regional_domain_name
    }
  }

  default_cache_behavior = {
    target_origin_id       = "s3_bucket"
    viewer_protocol_policy = "allow-all"
  }

  viewer_certificate = {
    cloudfront_default_certificate = true
  }
}

data "aws_availability_zones" "available" {}

module "vpc1" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "my-vpc-for-private-route53-zone"
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
}

module "vpc2" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "my-second-vpc-for-private-route53-zone"
  cidr = "10.1.0.0/16"
}

resource "aws_route53_resolver_rule" "sys" {
  domain_name = "sys-example.com"
  rule_type   = "SYSTEM"
}
