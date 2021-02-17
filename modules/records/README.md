# Route53 Records

This module creates DNS records in Route53 zone.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6 |
| aws | >= 2.49 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.49 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_route53_record](https://registry.terraform.io/providers/hashicorp/aws/2.49/docs/resources/route53_record) |
| [aws_route53_zone](https://registry.terraform.io/providers/hashicorp/aws/2.49/docs/data-sources/route53_zone) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create DNS records | `bool` | `true` | no |
| private\_zone | Whether Route53 zone is private or public | `bool` | `false` | no |
| records | List of maps of DNS records | `any` | `[]` | no |
| zone\_id | ID of DNS zone | `string` | `null` | no |
| zone\_name | Name of DNS zone | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_route53\_record\_fqdn | FQDN built using the zone domain and name |
| this\_route53\_record\_name | The name of the record |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
