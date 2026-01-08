# AWS Route53 Resolver Firewall Rule Group Terraform Module

Terraform module that creates:
- AWS Route53 Resolver Firewall Rule Group
- RAM resource association for sharing the rule group with other accounts
- Resolver firewall domain list(s)
- Resolver firewall rule(s)

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

```hcl
module "resolver_firewall_rule_group" {
  source = "terraform-aws-modules/route53/aws//modules/resolver-firewall-rule-group"

  name   = "example"

  rules = {
    block = {
      name           = "blockit"
      priority       = 110
      action         = "BLOCK"
      block_response = "NODATA"
      domains        = ["google.com."]

      tags = { rule = true }
    }
    block_override = {
      priority                = 120
      action                  = "BLOCK"
      block_response          = "OVERRIDE"
      block_override_dns_type = "CNAME"
      block_override_domain   = "example.com"
      block_override_ttl      = 1
      domains                 = ["microsoft.com."]
    }
    # Unfortunately, a data source does not exist yet to pull managed domain lists
    # but users can stil copy the managed domain list ID and paste it into the config
    # block_managed_domain_list = {
    #   priority       = 135
    #   action         = "BLOCK"
    #   block_response = "NODATA"
    #   domain_list_id =  data.aws_route53_resolver_firewall_domain_list.this.id # => "rslvr-fdl-fad18de921a64bfa"
    # }
    allow = {
      priority = 130
      action   = "ALLOW"
      domains  = ["amazon.com.", "amazonaws.com."]
    }
  }

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
| [aws_ram_resource_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_route53_resolver_firewall_domain_list.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_firewall_domain_list) | resource |
| [aws_route53_resolver_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_firewall_rule) | resource |
| [aws_route53_resolver_firewall_rule_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_firewall_rule_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | A name that lets you identify the rule group, to manage and use it | `string` | `""` | no |
| <a name="input_ram_resource_associations"></a> [ram\_resource\_associations](#input\_ram\_resource\_associations) | A map of RAM resource associations for the created rule group | <pre>map(object({<br/>    resource_share_arn = string<br/>  }))</pre> | `{}` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration | `string` | `null` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | A map of rule definitions to create | <pre>map(object({<br/>    name = optional(string)<br/><br/>    # Domain list<br/>    domains = optional(list(string))<br/><br/>    # Rule<br/>    action                             = string<br/>    block_override_dns_type            = optional(string)<br/>    block_override_domain              = optional(string)<br/>    block_override_ttl                 = optional(number)<br/>    block_response                     = optional(string)<br/>    firewall_domain_list_id            = optional(string)<br/>    firewall_domain_redirection_action = optional(string)<br/>    priority                           = number<br/>    q_type                             = optional(string)<br/><br/>    tags = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN (Amazon Resource Name) of the rule group |
| <a name="output_domain_lists"></a> [domain\_lists](#output\_domain\_lists) | Map of all domain lists created and their attributes |
| <a name="output_id"></a> [id](#output\_id) | The ID of the rule group |
| <a name="output_ram_resource_associations"></a> [ram\_resource\_associations](#output\_ram\_resource\_associations) | Map of RAM resource associations created and their attributes |
| <a name="output_rules"></a> [rules](#output\_rules) | Map of all rules created and their attributes |
| <a name="output_share_status"></a> [share\_status](#output\_share\_status) | Whether the rule group is shared with other AWS accounts, or was shared with the current account by another AWS account. Sharing is configured through AWS Resource Access Manager (AWS RAM). Valid values: `NOT_SHARED`, `SHARED_BY_ME`, `SHARED_WITH_ME` |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/LICENSE) for full details.
