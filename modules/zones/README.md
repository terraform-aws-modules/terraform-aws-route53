# Route53 Zones

This module creates Route53 zones.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create Route53 zone | `bool` | `true` | no |
| zones | Map of Route53 zone parameters | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_route53\_zone\_name\_servers | Name servers of Route53 zone |
| this\_route53\_zone\_zone\_id | Zone ID of Route53 zone |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
