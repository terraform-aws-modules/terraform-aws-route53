# Route53 Delegation Sets

This module creates Route53 delegation sets.

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create Route53 delegation sets | `bool` | `true` | no |
| delegation_sets | Map of Route53 delegation set parameters | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_route53\_delegation_set\_name\_servers | Name servers of Route53 delegation set |
| this\_route53\_delegation_set\_id | ID of Route53 delegation set |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
