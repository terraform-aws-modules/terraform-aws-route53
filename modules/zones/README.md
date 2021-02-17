# Route53 Zones

This module creates Route53 zones.

It can also automatically create delegation NS records in the parent zone
of each newly-created zone. This feature is activated by adding a 'parent_id'
element in the map defining the zone to create.

Note: When this feature is used, subdomains cannot be created with their
parent domain in the same module call and calls must be split. See the 'examples' subdirectory to see how it can be done.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.26 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.49 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.49 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create Route53 zone | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags added to all zones. Will take precedence over tags from the 'zones' variable | `map(any)` | `{}` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | Map of Route53 zone parameters | `any` | `{}` | no |

### Route53 zone parameters

Key: Zone name ('x.y.z.com')

Value:

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| comment | Comments | string | null | no |
| force_destroy | Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone | `bool` | `false` | no |
| vpc | vpc block to add to zone resource. Keys : vpc_id (mandatory), vpc_region (optional) | `map` | `{}` | no |
| tags | Tags | `map` | `{}` | no |
| parent_id | Id of zone where NS records for the new zone will be registered, or null if you don't want to create these records | string or null | null | no |
| ttl | ttl in seconds for the NS records in the parent zone| number | 300 | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_zone_name"></a> [route53\_zone\_name](#output\_route53\_zone\_name) | Name of Route53 zone |
| <a name="output_route53_zone_name_servers"></a> [route53\_zone\_name\_servers](#output\_route53\_zone\_name\_servers) | Name servers of Route53 zone |
| <a name="output_route53_zone_zone_id"></a> [route53\_zone\_zone\_id](#output\_route53\_zone\_zone\_id) | Zone ID of Route53 zone |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
