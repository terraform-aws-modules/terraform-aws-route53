# Complete

Configuration in this directory creates:

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which will incur monetary charges on your AWS bill. Run `terraform destroy` when you no longer need these resources.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | terraform-aws-modules/cloudfront/aws | ~> 5.0 |
| <a name="module_resolver_endpoint_disabled"></a> [resolver\_endpoint\_disabled](#module\_resolver\_endpoint\_disabled) | ../../modules/resolver-endpoint | n/a |
| <a name="module_resolver_endpoint_inbound"></a> [resolver\_endpoint\_inbound](#module\_resolver\_endpoint\_inbound) | ../../modules/resolver-endpoint | n/a |
| <a name="module_resolver_endpoint_outbound"></a> [resolver\_endpoint\_outbound](#module\_resolver\_endpoint\_outbound) | ../../modules/resolver-endpoint | n/a |
| <a name="module_resolver_firewall_rule_group"></a> [resolver\_firewall\_rule\_group](#module\_resolver\_firewall\_rule\_group) | ../../modules/resolver-firewall-rule-group | n/a |
| <a name="module_resolver_firewall_rule_group_disabled"></a> [resolver\_firewall\_rule\_group\_disabled](#module\_resolver\_firewall\_rule\_group\_disabled) | ../../modules/resolver-firewall-rule-group | n/a |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | ~> 5.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 6.0 |
| <a name="module_zone_disabled"></a> [zone\_disabled](#module\_zone\_disabled) | ../.. | n/a |
| <a name="module_zone_private"></a> [zone\_private](#module\_zone\_private) | ../.. | n/a |
| <a name="module_zone_public"></a> [zone\_public](#module\_zone\_public) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_health_check.failover](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_inbound_resolver_endpoint_arn"></a> [inbound\_resolver\_endpoint\_arn](#output\_inbound\_resolver\_endpoint\_arn) | The ARN of the Resolver Endpoint |
| <a name="output_inbound_resolver_endpoint_host_vpc_id"></a> [inbound\_resolver\_endpoint\_host\_vpc\_id](#output\_inbound\_resolver\_endpoint\_host\_vpc\_id) | The VPC ID used by the Resolver Endpoint |
| <a name="output_inbound_resolver_endpoint_id"></a> [inbound\_resolver\_endpoint\_id](#output\_inbound\_resolver\_endpoint\_id) | The ID of the Resolver Endpoint |
| <a name="output_inbound_resolver_endpoint_ip_addresses"></a> [inbound\_resolver\_endpoint\_ip\_addresses](#output\_inbound\_resolver\_endpoint\_ip\_addresses) | Resolver Endpoint IP Addresses |
| <a name="output_inbound_resolver_endpoint_rules"></a> [inbound\_resolver\_endpoint\_rules](#output\_inbound\_resolver\_endpoint\_rules) | Resolver Endpoint Rules created |
| <a name="output_inbound_resolver_endpoint_security_group_arn"></a> [inbound\_resolver\_endpoint\_security\_group\_arn](#output\_inbound\_resolver\_endpoint\_security\_group\_arn) | Amazon Resource Name (ARN) of the security group |
| <a name="output_inbound_resolver_endpoint_security_group_id"></a> [inbound\_resolver\_endpoint\_security\_group\_id](#output\_inbound\_resolver\_endpoint\_security\_group\_id) | ID of the security group |
| <a name="output_inbound_resolver_endpoint_security_group_ids"></a> [inbound\_resolver\_endpoint\_security\_group\_ids](#output\_inbound\_resolver\_endpoint\_security\_group\_ids) | Security Group IDs mapped to Resolver Endpoint |
| <a name="output_outbound_resolver_endpoint_arn"></a> [outbound\_resolver\_endpoint\_arn](#output\_outbound\_resolver\_endpoint\_arn) | The ARN of the Resolver Endpoint |
| <a name="output_outbound_resolver_endpoint_host_vpc_id"></a> [outbound\_resolver\_endpoint\_host\_vpc\_id](#output\_outbound\_resolver\_endpoint\_host\_vpc\_id) | The VPC ID used by the Resolver Endpoint |
| <a name="output_outbound_resolver_endpoint_id"></a> [outbound\_resolver\_endpoint\_id](#output\_outbound\_resolver\_endpoint\_id) | The ID of the Resolver Endpoint |
| <a name="output_outbound_resolver_endpoint_ip_addresses"></a> [outbound\_resolver\_endpoint\_ip\_addresses](#output\_outbound\_resolver\_endpoint\_ip\_addresses) | Resolver Endpoint IP Addresses |
| <a name="output_outbound_resolver_endpoint_rules"></a> [outbound\_resolver\_endpoint\_rules](#output\_outbound\_resolver\_endpoint\_rules) | Resolver Endpoint Rules created |
| <a name="output_outbound_resolver_endpoint_security_group_arn"></a> [outbound\_resolver\_endpoint\_security\_group\_arn](#output\_outbound\_resolver\_endpoint\_security\_group\_arn) | Amazon Resource Name (ARN) of the security group |
| <a name="output_outbound_resolver_endpoint_security_group_id"></a> [outbound\_resolver\_endpoint\_security\_group\_id](#output\_outbound\_resolver\_endpoint\_security\_group\_id) | ID of the security group |
| <a name="output_outbound_resolver_endpoint_security_group_ids"></a> [outbound\_resolver\_endpoint\_security\_group\_ids](#output\_outbound\_resolver\_endpoint\_security\_group\_ids) | Security Group IDs mapped to Resolver Endpoint |
| <a name="output_private_zone_arn"></a> [private\_zone\_arn](#output\_private\_zone\_arn) | Zone ARN of Route53 zone |
| <a name="output_private_zone_dnssec_kms_key_arn"></a> [private\_zone\_dnssec\_kms\_key\_arn](#output\_private\_zone\_dnssec\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key |
| <a name="output_private_zone_dnssec_kms_key_id"></a> [private\_zone\_dnssec\_kms\_key\_id](#output\_private\_zone\_dnssec\_kms\_key\_id) | The globally unique identifier for the key |
| <a name="output_private_zone_dnssec_kms_key_policy"></a> [private\_zone\_dnssec\_kms\_key\_policy](#output\_private\_zone\_dnssec\_kms\_key\_policy) | The IAM resource policy set on the key |
| <a name="output_private_zone_dnssec_kms_key_region"></a> [private\_zone\_dnssec\_kms\_key\_region](#output\_private\_zone\_dnssec\_kms\_key\_region) | The region for the key |
| <a name="output_private_zone_dnssec_signing_key_digest_value"></a> [private\_zone\_dnssec\_signing\_key\_digest\_value](#output\_private\_zone\_dnssec\_signing\_key\_digest\_value) | A cryptographic digest of a DNSKEY resource record (RR). DNSKEY records are used to publish the public key that resolvers can use to verify DNSSEC signatures that are used to secure certain kinds of information provided by the DNS system |
| <a name="output_private_zone_dnssec_signing_key_dnskey_record"></a> [private\_zone\_dnssec\_signing\_key\_dnskey\_record](#output\_private\_zone\_dnssec\_signing\_key\_dnskey\_record) | A string that represents a DNSKEY record |
| <a name="output_private_zone_dnssec_signing_key_ds_record"></a> [private\_zone\_dnssec\_signing\_key\_ds\_record](#output\_private\_zone\_dnssec\_signing\_key\_ds\_record) | A string that represents a delegation signer (DS) record |
| <a name="output_private_zone_dnssec_signing_key_id"></a> [private\_zone\_dnssec\_signing\_key\_id](#output\_private\_zone\_dnssec\_signing\_key\_id) | Route 53 Hosted Zone identifier and KMS Key identifier, separated by a comma (`,`) |
| <a name="output_private_zone_dnssec_signing_key_public_key"></a> [private\_zone\_dnssec\_signing\_key\_public\_key](#output\_private\_zone\_dnssec\_signing\_key\_public\_key) | The public key, represented as a Base64 encoding, as required by RFC-4034 Page 5 |
| <a name="output_private_zone_dnssec_signing_key_tag"></a> [private\_zone\_dnssec\_signing\_key\_tag](#output\_private\_zone\_dnssec\_signing\_key\_tag) | An integer used to identify the DNSSEC record for the domain name. The process used to calculate the value is described in RFC-4034 Appendix B |
| <a name="output_private_zone_id"></a> [private\_zone\_id](#output\_private\_zone\_id) | Zone ID of Route53 zone |
| <a name="output_private_zone_name"></a> [private\_zone\_name](#output\_private\_zone\_name) | Name of Route53 zone |
| <a name="output_private_zone_name_servers"></a> [private\_zone\_name\_servers](#output\_private\_zone\_name\_servers) | Name servers of Route53 zone |
| <a name="output_private_zone_primary_name_server"></a> [private\_zone\_primary\_name\_server](#output\_private\_zone\_primary\_name\_server) | The Route 53 name server that created the SOA record. |
| <a name="output_private_zone_records"></a> [private\_zone\_records](#output\_private\_zone\_records) | Records created in the Route53 zone |
| <a name="output_public_zone_arn"></a> [public\_zone\_arn](#output\_public\_zone\_arn) | Zone ARN of Route53 zone |
| <a name="output_public_zone_dnssec_kms_key_arn"></a> [public\_zone\_dnssec\_kms\_key\_arn](#output\_public\_zone\_dnssec\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key |
| <a name="output_public_zone_dnssec_kms_key_id"></a> [public\_zone\_dnssec\_kms\_key\_id](#output\_public\_zone\_dnssec\_kms\_key\_id) | The globally unique identifier for the key |
| <a name="output_public_zone_dnssec_kms_key_policy"></a> [public\_zone\_dnssec\_kms\_key\_policy](#output\_public\_zone\_dnssec\_kms\_key\_policy) | The IAM resource policy set on the key |
| <a name="output_public_zone_dnssec_kms_key_region"></a> [public\_zone\_dnssec\_kms\_key\_region](#output\_public\_zone\_dnssec\_kms\_key\_region) | The region for the key |
| <a name="output_public_zone_dnssec_signing_key_digest_value"></a> [public\_zone\_dnssec\_signing\_key\_digest\_value](#output\_public\_zone\_dnssec\_signing\_key\_digest\_value) | A cryptographic digest of a DNSKEY resource record (RR). DNSKEY records are used to publish the public key that resolvers can use to verify DNSSEC signatures that are used to secure certain kinds of information provided by the DNS system |
| <a name="output_public_zone_dnssec_signing_key_dnskey_record"></a> [public\_zone\_dnssec\_signing\_key\_dnskey\_record](#output\_public\_zone\_dnssec\_signing\_key\_dnskey\_record) | A string that represents a DNSKEY record |
| <a name="output_public_zone_dnssec_signing_key_ds_record"></a> [public\_zone\_dnssec\_signing\_key\_ds\_record](#output\_public\_zone\_dnssec\_signing\_key\_ds\_record) | A string that represents a delegation signer (DS) record |
| <a name="output_public_zone_dnssec_signing_key_id"></a> [public\_zone\_dnssec\_signing\_key\_id](#output\_public\_zone\_dnssec\_signing\_key\_id) | Route 53 Hosted Zone identifier and KMS Key identifier, separated by a comma (`,`) |
| <a name="output_public_zone_dnssec_signing_key_public_key"></a> [public\_zone\_dnssec\_signing\_key\_public\_key](#output\_public\_zone\_dnssec\_signing\_key\_public\_key) | The public key, represented as a Base64 encoding, as required by RFC-4034 Page 5 |
| <a name="output_public_zone_dnssec_signing_key_tag"></a> [public\_zone\_dnssec\_signing\_key\_tag](#output\_public\_zone\_dnssec\_signing\_key\_tag) | An integer used to identify the DNSSEC record for the domain name. The process used to calculate the value is described in RFC-4034 Appendix B |
| <a name="output_public_zone_id"></a> [public\_zone\_id](#output\_public\_zone\_id) | Zone ID of Route53 zone |
| <a name="output_public_zone_name"></a> [public\_zone\_name](#output\_public\_zone\_name) | Name of Route53 zone |
| <a name="output_public_zone_name_servers"></a> [public\_zone\_name\_servers](#output\_public\_zone\_name\_servers) | Name servers of Route53 zone |
| <a name="output_public_zone_primary_name_server"></a> [public\_zone\_primary\_name\_server](#output\_public\_zone\_primary\_name\_server) | The Route 53 name server that created the SOA record. |
| <a name="output_public_zone_records"></a> [public\_zone\_records](#output\_public\_zone\_records) | Records created in the Route53 zone |
| <a name="output_resolver_firewall_rule_group_arn"></a> [resolver\_firewall\_rule\_group\_arn](#output\_resolver\_firewall\_rule\_group\_arn) | The ARN (Amazon Resource Name) of the rule group |
| <a name="output_resolver_firewall_rule_group_domain_lists"></a> [resolver\_firewall\_rule\_group\_domain\_lists](#output\_resolver\_firewall\_rule\_group\_domain\_lists) | Map of all domain lists created and their attributes |
| <a name="output_resolver_firewall_rule_group_id"></a> [resolver\_firewall\_rule\_group\_id](#output\_resolver\_firewall\_rule\_group\_id) | The ID of the rule group |
| <a name="output_resolver_firewall_rule_group_rules"></a> [resolver\_firewall\_rule\_group\_rules](#output\_resolver\_firewall\_rule\_group\_rules) | Map of all rules created and their attributes |
| <a name="output_resolver_firewall_rule_group_share_status"></a> [resolver\_firewall\_rule\_group\_share\_status](#output\_resolver\_firewall\_rule\_group\_share\_status) | Whether the rule group is shared with other AWS accounts, or was shared with the current account by another AWS account. Sharing is configured through AWS Resource Access Manager (AWS RAM). Valid values: `NOT_SHARED`, `SHARED_BY_ME`, `SHARED_WITH_ME` |
| <a name="output_s3"></a> [s3](#output\_s3) | S3 bucket name used for logging |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-ecs/blob/master/LICENSE).
