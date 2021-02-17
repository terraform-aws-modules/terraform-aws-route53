# Route53 Zones

This module creates Route53 zones.

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
| [aws_route53_zone](https://registry.terraform.io/providers/hashicorp/aws/2.49/docs/resources/route53_zone) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create Route53 zone | `bool` | `true` | no |
| tags | Tags added to all zones. Will take precedence over tags from the 'zones' variable | `map(any)` | `{}` | no |
| zones | Map of Route53 zone parameters | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_route53\_zone\_name | Name of Route53 zone |
| this\_route53\_zone\_name\_servers | Name servers of Route53 zone |
| this\_route53\_zone\_zone\_id | Zone ID of Route53 zone |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
