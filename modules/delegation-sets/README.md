# Route53 Delegation Sets

This module creates Route53 delegation sets.

## Usage

### Create Route53 delegation sets and public zones using a delegation set

```hcl
module "delegation_sets" {
  source  = "terraform-aws-modules/route53/aws//modules/delegation-sets"
  version = "~> 2.0"

  delegation_sets = {
    "myset" = {
      reference_name = "myset"
    }
  }
}

module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"

  zones = {
    "myapp1.com" = {
      comment           = "myapp1.com"
      delegation_set_id = module.delegation_sets.route53_delegation_set_id["myset"]
    }

    "myapp2.com" = {
      comment           = "myapp2.com"
      delegation_set_id = module.delegation_sets.route53_delegation_set_id["myset"]
    }
  }

  tags = {
    ManagedBy = "Terraform"
  }

  depends_on = [module.delegation_sets]
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
| [aws_route53_delegation_set.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_delegation_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create Route53 delegation sets | `bool` | `true` | no |
| <a name="input_delegation_sets"></a> [delegation\_sets](#input\_delegation\_sets) | Map of Route53 delegation set parameters | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_delegation_set_id"></a> [route53\_delegation\_set\_id](#output\_route53\_delegation\_set\_id) | ID of Route53 delegation set |
| <a name="output_route53_delegation_set_name_servers"></a> [route53\_delegation\_set\_name\_servers](#output\_route53\_delegation\_set\_name\_servers) | Name servers in the Route53 delegation set |
| <a name="output_route53_delegation_set_reference_name"></a> [route53\_delegation\_set\_reference\_name](#output\_route53\_delegation\_set\_reference\_name) | Reference name used when the Route53 delegation set has been created |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
