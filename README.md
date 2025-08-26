# AWS Route53 Terraform modules

Terraform modules which creates Route53 resources.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

### Public Hosted Zone

```hcl
module "zone" {
  source = "terraform-aws-modules/route53/aws"

  name    = "terraform-aws-modules-example.com"
  comment = "Public zone for terraform-aws-modules example"

  records = {
    s3 = {
      name = "s3-bucket-z1bkctxd74ezpe.terraform-aws-modules-example.com"
      type = "A"
      alias = {
        name    = "s3-website-eu-west-1.amazonaws.com"
        zone_id = "Z1BKCTXD74EZPE"
      }
    }
    mail = {
      full_name = "terraform-aws-modules-example.com"
      type = "MX"
      ttl  = 3600
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
    cloudfront_ipv4 = {
      name = "cloudfront"
      type = "A"
      alias = {
        name    = "d3778kt32cqdww.cloudfront.net"
        zone_id = "EF3T6981F7M1"
      }
    }
    cloudfront_ipv6 = {
      name = "cloudfront"
      type = "AAAA"
      alias = {
        name    = "d3778kt32cqdww.cloudfront.net"
        zone_id = "EF3T6981F7M1"
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
      health_check_id = "d641c34c-a992-4edd-8a63-c540a4b18d0a"
      alias = {
        name    = "d3778kt32cqdww.cloudfront.net"
        zone_id = "EF3T6981F7M1"
      }
      failover_routing_policy = {
        type = "PRIMARY"
      }
    }
    failover-secondary = {
      type           = "A"
      set_identifier = "failover-secondary"
      alias = {
        name    = "s3-website-eu-west-1.amazonaws.com"
        zone_id = "Z1BKCTXD74EZPE"
      }
      failover_routing_policy = {
        type = "SECONDARY"
      }
    }
    latency-test = {
      type           = "A"
      set_identifier = "latency-test"
      alias = {
        name    = "d3778kt32cqdww.cloudfront.net"
        zone_id = "EF3T6981F7M1"
        evaluate_target_health = true
      }
      latency_routing_policy = {
        region = "eu-west-1"
      }
    }
  }

  tags = {
    Environment = "example"
    Project     = "terraform-aws-route53"
  }
}
```

### Private Hosted Zone

```hcl
module "zone" {
  source = "terraform-aws-modules/route53/aws"

  name    = "terraform-aws-modules-example.com"
  comment = "Private zone for terraform-aws-modules example"

  records = {
    "apigateway1" = {
      type    = "A"
      alias   = {
        name    = "d-10qxlbvagl.execute-api.eu-west-1.amazonaws.com"
        zone_id = "ZLY8HYME6SFAD"
      }
    }
    ip_alias = {
      name    = "terraform-aws-modules-example.com"
      type    = "A"
      ttl     = 3600
      records = [
        "10.10.10.10",
      ]
    }
  }

  vpc = {
    one = {
      vpc_id     = "vpc-1234556abcdef"
      vpc_region = "eu-west-1"
    }
  }

  tags = {
    Environment = "example"
    Project     = "terraform-aws-route53"
  }
}
```

## Sub-Modules

The following independent sub-modules are available:

- [resolver-endpoint](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/modules/resolver-endpoint) creates an AWS Route53 Resolver Endpoint and associated resources
- [resolver-firewall-rule-group](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/modules/resolver-firewall-rule-group) creates an AWS Route53 Resolver Firewall Rule Group and associated resources

See the respective module directories for examples and documentation.

## Examples

- [Complete](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/examples/complete)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained by [Anton Babenko](https://github.com/antonbabenko) with help from [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-route53/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/LICENSE) for full details.

## Additional information for users from Russia and Belarus

* Russia has [illegally annexed Crimea in 2014](https://en.wikipedia.org/wiki/Annexation_of_Crimea_by_the_Russian_Federation) and [brought the war in Donbas](https://en.wikipedia.org/wiki/War_in_Donbas) followed by [full-scale invasion of Ukraine in 2022](https://en.wikipedia.org/wiki/2022_Russian_invasion_of_Ukraine).
* Russia has brought sorrow and devastations to millions of Ukrainians, killed hundreds of innocent people, damaged thousands of buildings, and forced several million people to flee.
* [Putin khuylo!](https://en.wikipedia.org/wiki/Putin_khuylo!)
