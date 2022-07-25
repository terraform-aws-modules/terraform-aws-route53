# Route53 Zones Associations

This module creates Route53 zones associations.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
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
| [aws_route53_zone_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create Route53 zone | `bool` | `true` | no |
| <a name="input_zones_associations"></a> [zones\_associations](#input\_zones\_associations) | List of map of Route53 zone association parameters | `list(map(any))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_route53_zones_associations"></a> [aws\_route53\_zones\_associations](#output\_aws\_route53\_zones\_associations) | Zones associations of Route53 zone and VPCs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
