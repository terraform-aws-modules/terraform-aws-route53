provider "aws" {
  region = "eu-west-1"
}

locals {
  zone_name = sort(keys(module.zones.route53_zone_zone_id))[0]
  #  zone_id = module.zones.route53_zone_zone_id["app.terraform-aws-modules-example.com"]
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
      comment = "app.terraform-aws-modules-example.com"
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
          vpc_id = module.vpc.vpc_id
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
      name = "s3-bucket"
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
    }
  ]

  depends_on = [module.zones]
}

module "records_with_lists" {
  source = "../../modules/records"

  zone_name = local.zone_name
  #  zone_id = local.zone_id

  records = [
    {
      name = "tf-list1"
      type = "A"
      ttl  = 3600
      records = [
        "10.10.10.10",
      ]
    },
    {
      name = "tf-list2"
      type = "A"
      ttl  = 3600
      records = [
        "20.10.10.10",
        "30.10.10.10",
      ]
    },
  ]

  depends_on = [module.zones]
}

module "records_with_terragrunt" {
  source = "../../modules/records"

  zone_name = local.zone_name
  #  zone_id = local.zone_id

  # Terragrunt has a bug (https://github.com/gruntwork-io/terragrunt/issues/1211) that requires `records` to be wrapped with `jsonencode()`
  records = jsonencode([
    {
      name = "new"
      type = "A"
      ttl  = 3600
      records = [
        "10.10.10.10",
      ]
    },
    {
      name = "s3-bucket-new"
      type = "A"
      alias = {
        name    = module.s3_bucket.s3_bucket_website_domain
        zone_id = module.s3_bucket.s3_bucket_hosted_zone_id
      }
    }
  ])

  depends_on = [module.zones]
}

module "records_with_terragrunt_with_lists" {
  source = "../../modules/records"

  zone_name = local.zone_name
  #  zone_id = local.zone_id

  # Terragrunt has a bug (https://github.com/gruntwork-io/terragrunt/issues/1211) that requires `records` to be wrapped with `jsonencode()`
  records = jsonencode([
    {
      name = "tg-list1"
      type = "A"
      ttl  = 3600
      records = [
        "10.10.10.10",
      ]
    },
    {
      name = "tg-list2"
      type = "A"
      ttl  = 3600
      records = [
        "20.10.10.10",
        "30.10.10.10",
      ]
    }
  ])

  depends_on = [module.zones]
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
  source = "terraform-aws-modules/cloudfront/aws"

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

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc-for-private-route53-zone"
  cidr = "10.0.0.0/16"
}

module "vpc2" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-second-vpc-for-private-route53-zone"
  cidr = "10.1.0.0/16"
}
