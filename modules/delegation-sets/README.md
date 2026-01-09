# Route53 Delegation Sets

This module creates Route53 delegation sets.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

```hcl
module "delegation_sets" {
  source  = "terraform-aws-modules/route53/aws//modules/delegation-sets"

  delegation_sets = {
    "myapp1" = {
      reference_name = "myapp1"
    }
  }

  tags = {
    Environment = "example"
    Project     = "terraform-aws-route53"
  }
}

module "zones" {
  source  = "terraform-aws-modules/route53/aws"

  name = "myapp1.com"

  delegation_set_id = module.delegation_sets.route53_delegation_set_id["myapp1"]

  tags = {
    Environment = "example"
    Project     = "terraform-aws-route53"
  }
}
```

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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_delegation_set.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_delegation_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create Route53 delegation sets | `bool` | `true` | no |
| <a name="input_delegation_sets"></a> [delegation\_sets](#input\_delegation\_sets) | Map of Route53 delegation set parameters | <pre>map(object({<br/>    reference_name = optional(string)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_delegation_set_id"></a> [route53\_delegation\_set\_id](#output\_route53\_delegation\_set\_id) | ID of Route53 delegation set |
| <a name="output_route53_delegation_set_name_servers"></a> [route53\_delegation\_set\_name\_servers](#output\_route53\_delegation\_set\_name\_servers) | Name servers in the Route53 delegation set |
| <a name="output_route53_delegation_set_reference_name"></a> [route53\_delegation\_set\_reference\_name](#output\_route53\_delegation\_set\_reference\_name) | Reference name used when the Route53 delegation set has been created |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/LICENSE) for full details.
