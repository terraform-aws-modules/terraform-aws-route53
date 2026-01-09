# AWS Route53 Resolver Endpoint

Terraform module that creates:
- AWS Route53 Resolver Endpoint
- Security group and rules for port 53 on TCP and UDP

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

### Inbound Resolver Endpoint

```hcl
module "resolver_endpoint" {
  source = "terraform-aws-modules/route53/aws//modules/resolver-endpoint"

  name = "example-inbound"
  direction = "INBOUND"
  type      = "IPV4"
  protocols = ["Do53", "DoH"]

  ip_address = [
    {
      subnet_id = "subnet-abcde012"
    },
    {
      subnet_id = "subnet-bcde012a"
    }
  ]

  # Security group
  vpc_id = "vpc-1234556abcdef"
  security_group_ingress_rules = {
    one = {
      cidr_ipv4 = "10.0.0.0/20"
      description = "Allow inbound DNS queries from first subnet"
    }
    two = {
      cidr_ipv4 = "10.0.16.0/20"
      description = "Allow inbound DNS queries from second subnet"
    }
  }
  security_group_egress_rules = {
    one = {
      cidr_ipv4 = "10.0.0.0/20"
      description = "Allow outbound DNS responses to first subnet"
    }
    two = {
      cidr_ipv4 = "10.0.16.0/20"
      description = "Allow outbound DNS responses to second subnet"
    }
  }

  tags = {
    Environment = "example"
    Project     = "terraform-aws-route53"
  }
}
```

### Outbound Resolver Endpoint

```hcl
module "resolver_endpoint" {
  source = "terraform-aws-modules/route53/aws//modules/resolver-endpoint"

  name = "example-inbound"
  direction = "OUTBOUND"
  type      = "IPV4"
  protocols = ["Do53", "DoH"]

  ip_address = [
    {
      subnet_id = "subnet-abcde012"
    },
    {
      subnet_id = "subnet-bcde012a"
    }
  ]

  # Security group
  vpc_id = "vpc-1234556abcdef"
  security_group_ingress_rules = {
    one = {
      cidr_ipv4 = "10.0.0.0/20"
      description = "Allow inbound DNS queries from first subnet"
    }
    two = {
      cidr_ipv4 = "10.0.16.0/20"
      description = "Allow inbound DNS queries from second subnet"
    }
  }
  security_group_egress_rules = {
    one = {
      cidr_ipv4 = "10.0.0.0/20"
      description = "Allow outbound DNS responses to first subnet"
    }
    two = {
      cidr_ipv4 = "10.0.16.0/20"
      description = "Allow outbound DNS responses to second subnet"
    }
  }

  # Resolver Rule(s) & Association(s)
  rules = {
    ex-forward = {
      domain_name = "example.com."
      rule_type   = "FORWARD"
      target_ip = [{
        ip = "123.45.67.89"
      }]
      # Association
      vpc_id = "vpc-1234556abcdef"
    }
    ex-system = {
      domain_name = "system.com."
      rule_type   = "SYSTEM"
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
| [aws_route53_resolver_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |
| [aws_route53_resolver_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Determines if a security group is created | `bool` | `true` | no |
| <a name="input_direction"></a> [direction](#input\_direction) | Direction of DNS queries to or from the Route 53 Resolver endpoint. Valid values are `INBOUND` (resolver forwards DNS queries to the DNS service for a VPC from your network or another VPC) or `OUTBOUND` (resolver forwards DNS queries from the DNS service for a VPC to your network or another VPC) | `string` | `"INBOUND"` | no |
| <a name="input_ip_address"></a> [ip\_address](#input\_ip\_address) | Subnets and IP addresses in your VPC that you want DNS queries to pass through on the way from your VPCs to your network (for outbound endpoints) or on the way from your network to your VPCs (for inbound endpoints) | <pre>list(object({<br/>    ip        = optional(string)<br/>    ipv6      = optional(string)<br/>    subnet_id = string<br/>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Friendly name of the Route 53 Resolver endpoint | `string` | `null` | no |
| <a name="input_protocols"></a> [protocols](#input\_protocols) | Protocols you want to use for the Route 53 Resolver endpoint. Valid values are `DoH`, `Do53`, or `DoH-FIPS` | `list(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration | `string` | `null` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | A map of Route 53 Resolver rules & associations to create | <pre>map(object({<br/>    # Rule<br/>    domain_name = string<br/>    name        = optional(string)<br/>    rule_type   = string<br/>    tags        = optional(map(string), {})<br/>    target_ip = optional(list(object({<br/>      ip       = string<br/>      ipv6     = optional(string)<br/>      port     = optional(number)<br/>      protocol = optional(string)<br/>    })))<br/><br/>    # Association<br/>    vpc_id = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | Description of the security group created | `string` | `null` | no |
| <a name="input_security_group_egress_rules"></a> [security\_group\_egress\_rules](#input\_security\_group\_egress\_rules) | Security group tcp/udp on port 53 egress rules to add to the security group created | <pre>map(object({<br/>    name = optional(string)<br/><br/>    cidr_ipv4                    = optional(string)<br/>    cidr_ipv6                    = optional(string)<br/>    description                  = optional(string)<br/>    prefix_list_id               = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    tags                         = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | ID of one or more security groups that you want to use to control access to this VPC | `list(string)` | `[]` | no |
| <a name="input_security_group_ingress_rules"></a> [security\_group\_ingress\_rules](#input\_security\_group\_ingress\_rules) | Security group tcp/udp on port 53 ingress rules to add to the security group created | <pre>map(object({<br/>    name = optional(string)<br/><br/>    cidr_ipv4                    = optional(string)<br/>    cidr_ipv6                    = optional(string)<br/>    description                  = optional(string)<br/>    prefix_list_id               = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    tags                         = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name to use on security group created | `string` | `null` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | A map of additional tags to add to the security group created | `map(string)` | `{}` | no |
| <a name="input_security_group_use_name_prefix"></a> [security\_group\_use\_name\_prefix](#input\_security\_group\_use\_name\_prefix) | Determines whether the security group name (`security_group_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | Endpoint IP type. This endpoint type is applied to all IP addresses. Valid values are `IPV6`, `IPV4` or `DUALSTACK` (both IPv4 and IPv6) | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where the security group will be created | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the Resolver Endpoint |
| <a name="output_host_vpc_id"></a> [host\_vpc\_id](#output\_host\_vpc\_id) | The VPC ID used by the Resolver Endpoint |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Resolver Endpoint |
| <a name="output_ip_addresses"></a> [ip\_addresses](#output\_ip\_addresses) | Resolver Endpoint IP Addresses |
| <a name="output_rules"></a> [rules](#output\_rules) | Resolver Endpoint Rules created |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | Amazon Resource Name (ARN) of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | Security Group IDs mapped to Resolver Endpoint |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-route53/tree/master/LICENSE) for full details.
