provider "aws" {
  region = "eu-west-1"
}

module "zones" {
  source = "../../modules/zones"

  zones = {
    "terraform-aws-modules-example.com" = {
      comment = "terraform-aws-modules-examples.com (production)"
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
  }
}

module "records" {
  source = "../../modules/records"

  zone_name = keys(module.zones.this_route53_zone_zone_id)[0]
  //  zone_id = module.zones.this_route53_zone_zone_id["terraform-aws-modules-example.com"]

  records = [
    //    {
    //      name    = "apigateway1"
    //      type    = "A"
    //      alias = {
    //        name = "..."
    //        zone_id = "..."
    //      }
    //    },
    {
      name = ""
      type = "A"
      ttl  = 3600
      records = [
        "10.10.10.10",
      ]
    },
  ]

  depends_on = [module.zones]
}
