# Route53 Terraform module

Terraform module which creates Route53 resources.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

There are independent submodules:

- [zones](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/modules/zones) - to manage Route53 zones
- [records](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/modules/records) - to manage Route53 records
- [delegation-sets](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/modules/delegation-sets) - to manage Route53 delegation sets
- [resolver-endpoints](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/modules/resolver-endpoints) - to manage Route53 resolver endpoints
- [resolver-rule-associations](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/modules/resolver-rule-associations) - to manage Route53 resolver rule associations

## Usage

### Create Route53 zones and records

```hcl
module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 3.0"

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
  version = "~> 3.0"

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

## Additional information for users from Russia and Belarus

* Russia has [illegally annexed Crimea in 2014](https://en.wikipedia.org/wiki/Annexation_of_Crimea_by_the_Russian_Federation) and [brought the war in Donbas](https://en.wikipedia.org/wiki/War_in_Donbas) followed by [full-scale invasion of Ukraine in 2022](https://en.wikipedia.org/wiki/2022_Russian_invasion_of_Ukraine).
* Russia has brought sorrow and devastations to millions of Ukrainians, killed hundreds of innocent people, damaged thousands of buildings, and forced several million people to flee.
* [Putin khuylo!](https://en.wikipedia.org/wiki/Putin_khuylo!)
