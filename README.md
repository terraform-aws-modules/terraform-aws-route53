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

### Cross Account Zone Association

> [!NOTE]
> Association (`aws_route53_zone_association`) must be performed by the account that owns the VPC.
>
> Association authorization (`aws_route53_vpc_association_authorization`) must be performed by the account that owns the zone.
>
> Hence why the `aws_route53_zone_association` resource is *outside* the scope of the module, but the authorization (`aws_route53_vpc_association_authorization`) is *inside* the scope of the module.

> [!CAUTION]
> Since Terraform does not support variables in the `lifecycle_block`, the `ignore_vpc` variable is used to switch between two resources: `aws_route53_zone.this` and `aws_route53_zone.ignore_vpc`.
> Therefore, if you changes this value after resources have been created, Terraform will attempt to destroy and recreate the Route53 zone which is usually not desired. To avoid this,
> you will need to perform the appropriate state move commands/blocks between the two resources.
>
> Changing from `ignore_vpc = false` to `ignore_vpc = true`:
>
> ```bash
>terraform state mv 'module.zone.aws_route53_zone.this[0]' 'module.zone.aws_route53_zone.ignore_vpc[0]'
> ```
>
> Or using a state block:
>
>```hcl
>moved {
>  from = module.zone.aws_route53_zone.this[0]
>  to   = module.zone.aws_route53_zone.ignore_vpc[0]
>}
> ```
>
> Changing from `ignore_vpc = true` to `ignore_vpc = false`:
>
>```bash
>terraform state mv 'module.zone.aws_route53_zone.ignore_vpc[0]' 'module.zone.aws_route53_zone.this[0]'
> ```
>
> Or using a state block:
>
>```hcl
>moved {
>  from = module.zone.aws_route53_zone.ignore_vpc[0]
>  to   = module.zone.aws_route53_zone.this[0]
>}
> ```
>

```hcl
module "zone" {
  source = "terraform-aws-modules/route53/aws"

  name    = "terraform-aws-modules-example.com"
  comment = "Private zone for terraform-aws-modules example"

  # Ignore VPC after creation to avoid disruptive diff with associations
  ignore_vpc = true
  vpc = {
    default = {
      vpc_id     = "vpc-1234556abcdef"
      vpc_region = "eu-west-1"
    }
  }

  vpc_association_authorizations = {
    external = {
      vpc_id     = "vpc-987564fedcba"
      vpc_region = "eu-west-1"
    }
    external_region = {
      vpc_id     = "vpc-1a2b3c4d56e7f8"
      vpc_region = "us-east-1"
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

- [delegation-sets](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/modules/delegation-sets) creates AWS Route53 Delegation Sets
- [resolver-endpoint](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/modules/resolver-endpoint) creates an AWS Route53 Resolver Endpoint and associated resources
- [resolver-firewall-rule-group](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/modules/resolver-firewall-rule-group) creates an AWS Route53 Resolver Firewall Rule Group and associated resources

See the respective module directories for examples and documentation.

## Examples

- [Complete](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/examples/complete)
- [Cross Account](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/examples/cross-account)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.28 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.28 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_route53_dnssec_kms"></a> [route53\_dnssec\_kms](#module\_route53\_dnssec\_kms) | terraform-aws-modules/kms/aws | 4.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route53_hosted_zone_dnssec.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_hosted_zone_dnssec) | resource |
| [aws_route53_key_signing_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_key_signing_key) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_vpc_association_authorization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_vpc_association_authorization) | resource |
| [aws_route53_zone.ignore_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_comment"></a> [comment](#input\_comment) | A comment for the hosted zone. Defaults to `Managed by Terraform` | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create Route53 zone | `bool` | `true` | no |
| <a name="input_create_dnssec_kms_key"></a> [create\_dnssec\_kms\_key](#input\_create\_dnssec\_kms\_key) | Whether to create a KMS key for DNSSEC signing | `bool` | `true` | no |
| <a name="input_create_zone"></a> [create\_zone](#input\_create\_zone) | Determines whether to create the Route53 zone or lookup an existing zone | `bool` | `true` | no |
| <a name="input_delegation_set_id"></a> [delegation\_set\_id](#input\_delegation\_set\_id) | The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones | `string` | `null` | no |
| <a name="input_dnssec_kms_key_aliases"></a> [dnssec\_kms\_key\_aliases](#input\_dnssec\_kms\_key\_aliases) | A list of aliases to create. Note - due to the use of `toset()`, values must be static strings and not computed values | `list(string)` | `[]` | no |
| <a name="input_dnssec_kms_key_arn"></a> [dnssec\_kms\_key\_arn](#input\_dnssec\_kms\_key\_arn) | The ARN of the KMS key to use for DNSSEC signing. Required when `create_dnssec_kms_key` is `false` | `string` | `null` | no |
| <a name="input_dnssec_kms_key_description"></a> [dnssec\_kms\_key\_description](#input\_dnssec\_kms\_key\_description) | The description of the key as viewed in AWS console | `string` | `"Route53 DNSSEC KMS Key"` | no |
| <a name="input_dnssec_kms_key_tags"></a> [dnssec\_kms\_key\_tags](#input\_dnssec\_kms\_key\_tags) | Additional tags to apply to the KMS key created for DNSSEC signing | `map(string)` | `{}` | no |
| <a name="input_enable_accelerated_recovery"></a> [enable\_accelerated\_recovery](#input\_enable\_accelerated\_recovery) | Whether to enable Route 53 Accelerated Recovery for the public hosted zone. When enabled, provides a 60-minute RTO for resuming DNS record management if the US East (N. Virginia) Region becomes unavailable. Only applies to public hosted zones | `bool` | `null` | no |
| <a name="input_enable_dnssec"></a> [enable\_dnssec](#input\_enable\_dnssec) | Whether to enable DNSSEC for the Route53 zone | `bool` | `false` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone | `bool` | `null` | no |
| <a name="input_ignore_vpc"></a> [ignore\_vpc](#input\_ignore\_vpc) | Determines whether to ignore VPC association changes after creation to avoid disruptive diffs when using `aws_route53_zone_association` resource(s). Changing is a destructive action; users should be prepared to use Terraform state move commands/blocks when changing this value | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | This is the name of the hosted zone | `string` | `""` | no |
| <a name="input_private_zone"></a> [private\_zone](#input\_private\_zone) | Whether the hosted zone is private. Only applicable when `create_zone = false` | `bool` | `false` | no |
| <a name="input_records"></a> [records](#input\_records) | A map of Route53 records to create in the zone. The key can be used as the subdomain name, or `name` can be used to specify the full name | <pre>map(object({<br/>    alias = optional(object({<br/>      evaluate_target_health = optional(bool, false)<br/>      name                   = string<br/>      zone_id                = string<br/>    }))<br/>    allow_overwrite = optional(bool)<br/>    cidr_routing_policy = optional(object({<br/>      collection_id = string<br/>      location_name = string<br/>    }))<br/>    failover_routing_policy = optional(object({<br/>      type = string<br/>    }))<br/>    geolocation_routing_policy = optional(object({<br/>      continent   = optional(string)<br/>      country     = optional(string)<br/>      subdivision = optional(string)<br/>    }))<br/>    geoproximity_routing_policy = optional(object({<br/>      aws_region = optional(string)<br/>      bias       = optional(number)<br/>      coordinates = optional(list(object({<br/>        latitude  = number<br/>        longitude = number<br/>      })))<br/>      local_zone_group = optional(string)<br/>    }))<br/>    health_check_id = optional(string)<br/>    latency_routing_policy = optional(object({<br/>      region = string<br/>    }))<br/>    multivalue_answer_routing_policy = optional(bool)<br/>    name                             = optional(string)<br/>    full_name                        = optional(string)<br/>    records                          = optional(list(string))<br/>    set_identifier                   = optional(string)<br/>    ttl                              = optional(number)<br/>    type                             = string<br/>    weighted_routing_policy = optional(object({<br/>      weight = number<br/>    }))<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags added to all zones. Will take precedence over tags from the 'zones' variable | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeouts for the Route53 zone operations | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | Configuration block(s) specifying VPC(s) to associate with a private hosted zone. Conflicts with the delegation\_set\_id argument in this resource and any aws\_route53\_zone\_association resource specifying the same zone ID | <pre>map(object({<br/>    vpc_id     = string<br/>    vpc_region = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_vpc_association_authorizations"></a> [vpc\_association\_authorizations](#input\_vpc\_association\_authorizations) | A map of VPC association authorizations to create for the Route53 zone | <pre>map(object({<br/>    vpc_id     = string<br/>    vpc_region = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC associated with the existing hosted zone. Only applicable when `create_zone = false` | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Zone ARN of Route53 zone |
| <a name="output_dnssec_kms_key_arn"></a> [dnssec\_kms\_key\_arn](#output\_dnssec\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key |
| <a name="output_dnssec_kms_key_id"></a> [dnssec\_kms\_key\_id](#output\_dnssec\_kms\_key\_id) | The globally unique identifier for the key |
| <a name="output_dnssec_kms_key_policy"></a> [dnssec\_kms\_key\_policy](#output\_dnssec\_kms\_key\_policy) | The IAM resource policy set on the key |
| <a name="output_dnssec_kms_key_region"></a> [dnssec\_kms\_key\_region](#output\_dnssec\_kms\_key\_region) | The region for the key |
| <a name="output_dnssec_signing_key_digest_value"></a> [dnssec\_signing\_key\_digest\_value](#output\_dnssec\_signing\_key\_digest\_value) | A cryptographic digest of a DNSKEY resource record (RR). DNSKEY records are used to publish the public key that resolvers can use to verify DNSSEC signatures that are used to secure certain kinds of information provided by the DNS system |
| <a name="output_dnssec_signing_key_dnskey_record"></a> [dnssec\_signing\_key\_dnskey\_record](#output\_dnssec\_signing\_key\_dnskey\_record) | A string that represents a DNSKEY record |
| <a name="output_dnssec_signing_key_ds_record"></a> [dnssec\_signing\_key\_ds\_record](#output\_dnssec\_signing\_key\_ds\_record) | A string that represents a delegation signer (DS) record |
| <a name="output_dnssec_signing_key_id"></a> [dnssec\_signing\_key\_id](#output\_dnssec\_signing\_key\_id) | Route 53 Hosted Zone identifier and KMS Key identifier, separated by a comma (`,`) |
| <a name="output_dnssec_signing_key_public_key"></a> [dnssec\_signing\_key\_public\_key](#output\_dnssec\_signing\_key\_public\_key) | The public key, represented as a Base64 encoding, as required by RFC-4034 Page 5 |
| <a name="output_dnssec_signing_key_tag"></a> [dnssec\_signing\_key\_tag](#output\_dnssec\_signing\_key\_tag) | An integer used to identify the DNSSEC record for the domain name. The process used to calculate the value is described in RFC-4034 Appendix B |
| <a name="output_id"></a> [id](#output\_id) | Zone ID of Route53 zone |
| <a name="output_name"></a> [name](#output\_name) | Name of Route53 zone |
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | Name servers of Route53 zone |
| <a name="output_primary_name_server"></a> [primary\_name\_server](#output\_primary\_name\_server) | The Route 53 name server that created the SOA record. |
| <a name="output_records"></a> [records](#output\_records) | Records created in the Route53 zone |
<!-- END_TF_DOCS -->

## Authors

Module is maintained by [Anton Babenko](https://github.com/antonbabenko) with help from [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-route53/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/LICENSE) for full details.

## Additional information for users from Russia and Belarus

* Russia has [illegally annexed Crimea in 2014](https://en.wikipedia.org/wiki/Annexation_of_Crimea_by_the_Russian_Federation) and [brought the war in Donbas](https://en.wikipedia.org/wiki/War_in_Donbas) followed by [full-scale invasion of Ukraine in 2022](https://en.wikipedia.org/wiki/2022_Russian_invasion_of_Ukraine).
* Russia has brought sorrow and devastations to millions of Ukrainians, killed hundreds of innocent people, damaged thousands of buildings, and forced several million people to flee.
* [Putin khuylo!](https://en.wikipedia.org/wiki/Putin_khuylo!)
