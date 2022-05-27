# Route53 Resolver Rule Associations

This module creates Route53 resolver rule associations.

## Usage

### Create Route53 Resolver rule associations

```hcl
module "resolver_rule_associations" {
  source  = "terraform-aws-modules/route53/aws//modules/resolver-rule-associations"
  version = "~> 2.0"

  vpc_id = "vpc-185a3e2f2d6d2c863"

  resolver_rule_associations = {
    foo = {
      resolver_rule_id = "rslvr-rr-2d3e8e42eea14f20a"
    },
    bar = {
      name             = "bar"
      resolver_rule_id = "rslvr-rr-2d3e8e42eea14f20a"
      vpc_id           = "vpc-285a3e2f2d6d2c863"
    },
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.56 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.56 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_resolver_rule_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create Route53 Resolver rule associations | `bool` | `true` | no |
| <a name="input_resolver_rule_associations"></a> [resolver\_rule\_associations](#input\_resolver\_rule\_associations) | Map of Route53 Resolver rule associations parameters | `any` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Default VPC ID for all the Route53 Resolver rule associations | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_resolver_rule_association_id"></a> [route53\_resolver\_rule\_association\_id](#output\_route53\_resolver\_rule\_association\_id) | ID of Route53 Resolver rule associations |
| <a name="output_route53_resolver_rule_association_name"></a> [route53\_resolver\_rule\_association\_name](#output\_route53\_resolver\_rule\_association\_name) | Name of Route53 Resolver rule associations |
| <a name="output_route53_resolver_rule_association_resolver_rule_id"></a> [route53\_resolver\_rule\_association\_resolver\_rule\_id](#output\_route53\_resolver\_rule\_association\_resolver\_rule\_id) | ID of Route53 Resolver rule associations resolver rule |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
