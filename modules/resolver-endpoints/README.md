# Route53 Resolver Endpoints

This module creates Route53 Resolver Endpoints.

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
| [aws_route53_resolver_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create Route53 resolver endpoints | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Whether to create Security Groups for Route53 Resolver Endpoints | `bool` | `true` | no |
| <a name="input_direction"></a> [direction](#input\_direction) | The resolver endpoint flow direction | `string` | `"INBOUND"` | no |
| <a name="input_name"></a> [name](#input\_name) | The resolver endpoint name | `string` | n/a | yes |
| <a name="input_protocols"></a> [protocols](#input\_protocols) | The resolver endpoint protocols | `list(string)` | n/a | yes |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | The security group description | `string` | `"Managed by Terraform."` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of security group IDs | `list(string)` | `[]` | no |
| <a name="input_security_group_ingress_cidr_blocks"></a> [security\_group\_ingress\_cidr\_blocks](#input\_security\_group\_ingress\_cidr\_blocks) | A list of CIDR blocks to allow on security group | `list(string)` | `[]` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | The security group name | `string` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnets where Route53 resolver endpoints will be deployed | `list(string)` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | The resolver endpoint IP type | `string` | `"IPV4"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID for all the Route53 Resolver Endpoints | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_resolver_endpoint_arn"></a> [route53\_resolver\_endpoint\_arn](#output\_route53\_resolver\_endpoint\_arn) | The ARN of the Resolver Endpoint |
| <a name="output_route53_resolver_endpoint_id"></a> [route53\_resolver\_endpoint\_id](#output\_route53\_resolver\_endpoint\_id) | The ID of the Resolver Endpoint |
| <a name="output_route53_resolver_endpoint_ip_addresses"></a> [route53\_resolver\_endpoint\_ip\_addresses](#output\_route53\_resolver\_endpoint\_ip\_addresses) | Resolver Endpoint IP Addresses |
| <a name="output_route53_resolver_endpoint_security_groups"></a> [route53\_resolver\_endpoint\_security\_groups](#output\_route53\_resolver\_endpoint\_security\_groups) | Security Group IDs mapped to Resolver Endpoint |
| <a name="output_route53_resolver_endpoint_vpc_id"></a> [route53\_resolver\_endpoint\_vpc\_id](#output\_route53\_resolver\_endpoint\_vpc\_id) | The VPC ID used by the Resolver Endpoint |
