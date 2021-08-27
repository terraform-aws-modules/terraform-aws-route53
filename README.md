# Route53 Terraform module

Terraform module which creates Route53 resources.

There are independent submodules:

- [zones](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/modules/zones) - to manage Route53 zones
- [records](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/modules/records) - to manage Route53 records

## Usage

### Create Route53 zones and records

```hcl
module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"

  zones = {
    "terraform-aws-modules-example.com" = {
      comment = "terraform-aws-modules-examples.com (production)"
      tags = {
        env = "production"
      }
    }

    "myapp.com" = {
      comment = "myapp.com"
    }
  }

  tags = {
    ManagedBy = "Terraform"
  }
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = keys(module.zones.route53_zone_zone_id)[0]

  records = [
    {
      name    = "apigateway1"
      type    = "A"
      alias   = {
        name    = "d-10qxlbvagl.execute-api.eu-west-1.amazonaws.com"
        zone_id = "ZLY8HYME6SFAD"
      }
    },
    {
      name    = ""
      type    = "A"
      ttl     = 3600
      records = [
        "10.10.10.10",
      ]
    },
  ]

  depends_on = [module.zones]
}
```

## Examples

- [Complete Route53 zones and records example](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/examples/complete) which shows how to create Route53 records of various types like S3 bucket and CloudFront distribution.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained by [Anton Babenko](https://github.com/antonbabenko) with help from [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-route53/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/LICENSE) for full details.
