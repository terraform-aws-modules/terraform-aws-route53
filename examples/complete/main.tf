provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  region = "eu-west-1"
  name   = "ex-${basename(path.cwd)}"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-route53"
  }
}

################################################################################
# Zone
################################################################################

module "zone_public" {
  source = "../.."

  name    = "terraform-aws-modules-example.com"
  comment = "Public zone for terraform-aws-modules example"

  # Accelerated Recovery - provides 60-minute RTO for DNS management if us-east-1 is unavailable
  enable_accelerated_recovery = false

  # DNSSEC
  enable_dnssec = true

  records = {
    s3 = {
      # Have to use `name` due to computed values (cannot use as key)
      name = "s3-bucket-${module.s3_bucket.s3_bucket_hosted_zone_id}"
      type = "A"
      alias = {
        name    = module.s3_bucket.s3_bucket_website_domain
        zone_id = module.s3_bucket.s3_bucket_hosted_zone_id
      }
    }
    mail = {
      full_name = "terraform-aws-modules-example.com"
      type      = "MX"
      ttl       = 3600
      records = [
        "1 aspmx.l.google.com",
        "5 alt1.aspmx.l.google.com",
        "5 alt2.aspmx.l.google.com",
        "10 alt3.aspmx.l.google.com",
        "10 alt4.aspmx.l.google.com",
      ]
    }
    geo = {
      type           = "CNAME"
      ttl            = 5
      records        = ["europe.test.example.com."]
      set_identifier = "europe"
      geolocation_routing_policy = {
        continent = "EU"
      }
    }
    geoproximity-aws-region = {
      type           = "CNAME"
      ttl            = 5
      records        = ["us-east-1.test.example.com."]
      set_identifier = "us-east-1-region"
      geoproximity_routing_policy = {
        aws_region = "us-east-1"
        bias       = 0
      }
    }
    geoproximity-coordinates = {
      type           = "CNAME"
      ttl            = 5
      records        = ["nyc.test.example.com."]
      set_identifier = "nyc"
      geoproximity_routing_policy = {
        coordinates = [{
          latitude  = "40.71"
          longitude = "-74.01"
        }]
      }
    }
    cloudfront = {
      type = "A"
      alias = {
        name    = module.cloudfront.cloudfront_distribution_domain_name
        zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
      }
    }
    cloudfront_ipv6 = {
      name = "cloudfront"
      type = "AAAA"
      alias = {
        name    = module.cloudfront.cloudfront_distribution_domain_name
        zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
      }
    }
    blue = {
      name           = "test"
      type           = "CNAME"
      ttl            = 5
      records        = ["test.example.com."]
      set_identifier = "test-primary"
      weighted_routing_policy = {
        weight = 90
      }
    }
    green = {
      name           = "test"
      type           = "CNAME"
      ttl            = 5
      records        = ["test2.example.com."]
      set_identifier = "test-secondary"
      weighted_routing_policy = {
        weight = 10
      }
    }
    failover-primary = {
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
    }
    failover-secondary = {
      type           = "A"
      set_identifier = "failover-secondary"
      alias = {
        name    = module.s3_bucket.s3_bucket_website_domain
        zone_id = module.s3_bucket.s3_bucket_hosted_zone_id
      }
      failover_routing_policy = {
        type = "SECONDARY"
      }
    }
    latency-test = {
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
  }

  tags = local.tags
}

module "zone_private" {
  source = "../.."

  name    = "terraform-aws-modules-example.com"
  comment = "Private zone for terraform-aws-modules example"

  vpc = {
    one = {
      vpc_id     = module.vpc.vpc_id
      vpc_region = local.region
    }
  }

  tags = local.tags
}

module "zone_disabled" {
  source = "../.."

  create = false
}

################################################################################
# Resolver Endpoint
################################################################################

module "resolver_endpoint_inbound" {
  source = "../../modules/resolver-endpoint"

  name      = "${local.name}-inbound"
  direction = "INBOUND"
  type      = "IPV4"
  protocols = ["Do53", "DoH"]

  ip_address = [
    {
      subnet_id = element(module.vpc.private_subnets, 0)
    },
    {
      subnet_id = element(module.vpc.private_subnets, 1)
    }
  ]

  # Security group
  vpc_id = module.vpc.vpc_id
  security_group_ingress_rules = {
    one = {
      cidr_ipv4   = element(module.vpc.private_subnets_cidr_blocks, 0)
      description = "Allow inbound DNS queries from first subnet"
    }
    two = {
      cidr_ipv4   = element(module.vpc.private_subnets_cidr_blocks, 1)
      description = "Allow inbound DNS queries from second subnet"
    }
  }
  security_group_egress_rules = {
    one = {
      cidr_ipv4   = element(module.vpc.private_subnets_cidr_blocks, 0)
      description = "Allow outbound DNS responses to first subnet"
    }
    two = {
      cidr_ipv4   = element(module.vpc.private_subnets_cidr_blocks, 1)
      description = "Allow outbound DNS responses to second subnet"
    }
  }

  tags = local.tags
}

module "resolver_endpoint_outbound" {
  source = "../../modules/resolver-endpoint"

  name      = "${local.name}-outbound"
  direction = "OUTBOUND"
  type      = "IPV4"
  protocols = ["Do53", "DoH"]

  # Using fixed IP addresses
  ip_address = [
    {
      ip        = "10.0.0.35"
      subnet_id = element(module.vpc.private_subnets, 0)
    },
    {
      ip        = "10.0.16.285"
      subnet_id = element(module.vpc.private_subnets, 1)
    }
  ]

  # Security group
  vpc_id = module.vpc.vpc_id
  security_group_ingress_rules = {
    one = {
      cidr_ipv4   = element(module.vpc.private_subnets_cidr_blocks, 0)
      description = "Allow inbound DNS queries from first subnet"
    }
    two = {
      cidr_ipv4   = element(module.vpc.private_subnets_cidr_blocks, 1)
      description = "Allow inbound DNS queries from second subnet"
    }
  }
  security_group_egress_rules = {
    one = {
      cidr_ipv4   = element(module.vpc.private_subnets_cidr_blocks, 0)
      description = "Allow outbound DNS responses to first subnet"
    }
    two = {
      cidr_ipv4   = element(module.vpc.private_subnets_cidr_blocks, 1)
      description = "Allow outbound DNS responses to second subnet"
    }
  }

  # Resolver Rule(s) & Association(s)
  rules = {
    ex-forward = {
      domain_name = "example.com."
      rule_type   = "FORWARD"
      target_ip = [{
        ip = "123.45.67.89"
      }]
      # Association
      vpc_id = module.vpc.vpc_id
    }
    ex-system = {
      domain_name = "system.com."
      rule_type   = "SYSTEM"
    }
  }

  tags = local.tags
}

module "resolver_endpoint_disabled" {
  source = "../../modules/resolver-endpoint"

  create = false
}

################################################################################
# DNS Firewall Module
################################################################################

module "resolver_firewall_rule_group" {
  source = "../../modules/resolver-firewall-rule-group"

  name = local.name

  rules = {
    block = {
      name           = "blockit"
      priority       = 110
      action         = "BLOCK"
      block_response = "NODATA"
      domains        = ["google.com."]
    }
    block_override = {
      priority                = 120
      action                  = "BLOCK"
      block_response          = "OVERRIDE"
      block_override_dns_type = "CNAME"
      block_override_domain   = "example.com."
      block_override_ttl      = 1
      domains                 = ["microsoft.com."]
    }
    allow = {
      priority = 130
      action   = "ALLOW"
      domains  = ["amazon.com.", "amazonaws.com."]
    }
  }

  tags = local.tags
}

module "resolver_firewall_rule_group_disabled" {
  source = "../../modules/resolver-firewall-rule-group"

  create = false
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]

  tags = local.tags
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.0"

  bucket_prefix = "s3-bucket-"
  force_destroy = true

  website = {
    index_document = "index.html"
  }

  tags = local.tags
}

module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "~> 5.0"

  enabled             = false
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

  tags = local.tags
}

resource "aws_route53_health_check" "failover" {
  fqdn              = module.cloudfront.cloudfront_distribution_domain_name
  port              = 443
  type              = "HTTPS"
  resource_path     = "/index.html"
  failure_threshold = 3
  request_interval  = 30

  tags = local.tags
}
