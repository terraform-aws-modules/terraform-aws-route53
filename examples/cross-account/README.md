# Cross Account Route53 Zone Association

Configuration in this directory creates:

- A Route53 Private Hosted Zone w/ associated VPC in one AWS account
- A VPC in another AWS account, associated to the Private Hosted Zone in the first account
- A VPC in another AWS account and region, associated to the Private Hosted Zone in the first account

> [!NOTE]
> Association (`aws_route53_zone_association`) must be performed by the account that owns the VPC.
>
> Association authorization (`aws_route53_vpc_association_authorization`) must be performed by the account that owns the zone.
>
> Hence why the `aws_route53_zone_association` resource is *outside* the scope of the module, but the authorization (`aws_route53_vpc_association_authorization`) is *inside* the scope of the module.

> [!CAUTION]
> Since Terraform does not support variables in the `lifecycle_block`, the `ignore_vpc` variable is used to switch between two resources: `aws_route53_zone.this` and `aws_route53_zone.ignore_vpc`.
> Therefore, if you changes this value after resources have been created, Terraform will attempt to destroy and recreate the Route53 zone which is usually not desired. To avoid this,
> you will need to perform the appropriate state move commands/blocks between the two resources.
>
> Changing from `ignore_vpc = false` to `ignore_vpc = true`:
>
> ```bash
>terraform state mv 'module.zone.aws_route53_zone.this[0]' 'module.zone.aws_route53_zone.ignore_vpc[0]'
> ```
>
> Or using a state block:
>
>```hcl
>moved {
>  from = module.zone.aws_route53_zone.this[0]
>  to   = module.zone.aws_route53_zone.ignore_vpc[0]
>}
> ```
>
> Changing from `ignore_vpc = true` to `ignore_vpc = false`:
>
>```bash
>terraform state mv 'module.zone.aws_route53_zone.ignore_vpc[0]' 'module.zone.aws_route53_zone.this[0]'
> ```
>
> Or using a state block:
>
>```hcl
>moved {
>  from = module.zone.aws_route53_zone.ignore_vpc[0]
>  to   = module.zone.aws_route53_zone.this[0]
>}
> ```
>

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
| <a name="provider_aws.external"></a> [aws.external](#provider\_aws.external) | >= 6.28 |
| <a name="provider_aws.external_region"></a> [aws.external\_region](#provider\_aws.external\_region) | >= 6.28 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 6.0 |
| <a name="module_vpc_external"></a> [vpc\_external](#module\_vpc\_external) | terraform-aws-modules/vpc/aws | ~> 6.0 |
| <a name="module_vpc_external_region"></a> [vpc\_external\_region](#module\_vpc\_external\_region) | terraform-aws-modules/vpc/aws | ~> 6.0 |
| <a name="module_zone"></a> [zone](#module\_zone) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_zone_association.external](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone_association) | resource |
| [aws_route53_zone_association.external_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone_association) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_availability_zones.external_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_external_account_role_arn"></a> [external\_account\_role\_arn](#input\_external\_account\_role\_arn) | The ARN of the role to assume in the external account containing the VPC to be associated to the Route53 private zone | `string` | `"YOU MUST PROVIDE THIS VALUE"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_zone_arn"></a> [zone\_arn](#output\_zone\_arn) | Zone ARN of Route53 zone |
| <a name="output_zone_dnssec_kms_key_arn"></a> [zone\_dnssec\_kms\_key\_arn](#output\_zone\_dnssec\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key |
| <a name="output_zone_dnssec_kms_key_id"></a> [zone\_dnssec\_kms\_key\_id](#output\_zone\_dnssec\_kms\_key\_id) | The globally unique identifier for the key |
| <a name="output_zone_dnssec_kms_key_policy"></a> [zone\_dnssec\_kms\_key\_policy](#output\_zone\_dnssec\_kms\_key\_policy) | The IAM resource policy set on the key |
| <a name="output_zone_dnssec_kms_key_region"></a> [zone\_dnssec\_kms\_key\_region](#output\_zone\_dnssec\_kms\_key\_region) | The region for the key |
| <a name="output_zone_dnssec_signing_key_digest_value"></a> [zone\_dnssec\_signing\_key\_digest\_value](#output\_zone\_dnssec\_signing\_key\_digest\_value) | A cryptographic digest of a DNSKEY resource record (RR). DNSKEY records are used to publish the public key that resolvers can use to verify DNSSEC signatures that are used to secure certain kinds of information provided by the DNS system |
| <a name="output_zone_dnssec_signing_key_dnskey_record"></a> [zone\_dnssec\_signing\_key\_dnskey\_record](#output\_zone\_dnssec\_signing\_key\_dnskey\_record) | A string that represents a DNSKEY record |
| <a name="output_zone_dnssec_signing_key_ds_record"></a> [zone\_dnssec\_signing\_key\_ds\_record](#output\_zone\_dnssec\_signing\_key\_ds\_record) | A string that represents a delegation signer (DS) record |
| <a name="output_zone_dnssec_signing_key_id"></a> [zone\_dnssec\_signing\_key\_id](#output\_zone\_dnssec\_signing\_key\_id) | Route 53 Hosted Zone identifier and KMS Key identifier, separated by a comma (`,`) |
| <a name="output_zone_dnssec_signing_key_public_key"></a> [zone\_dnssec\_signing\_key\_public\_key](#output\_zone\_dnssec\_signing\_key\_public\_key) | The public key, represented as a Base64 encoding, as required by RFC-4034 Page 5 |
| <a name="output_zone_dnssec_signing_key_tag"></a> [zone\_dnssec\_signing\_key\_tag](#output\_zone\_dnssec\_signing\_key\_tag) | An integer used to identify the DNSSEC record for the domain name. The process used to calculate the value is described in RFC-4034 Appendix B |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | Zone ID of Route53 zone |
| <a name="output_zone_name"></a> [zone\_name](#output\_zone\_name) | Name of Route53 zone |
| <a name="output_zone_name_servers"></a> [zone\_name\_servers](#output\_zone\_name\_servers) | Name servers of Route53 zone |
| <a name="output_zone_primary_name_server"></a> [zone\_primary\_name\_server](#output\_zone\_primary\_name\_server) | The Route 53 name server that created the SOA record. |
| <a name="output_zone_records"></a> [zone\_records](#output\_zone\_records) | Records created in the Route53 zone |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-ecs/blob/master/LICENSE).
