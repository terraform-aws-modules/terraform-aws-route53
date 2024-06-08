# Route53 zones and records example

Configuration in this directory creates Route53 zones and records for various types of resources - S3 bucket, CloudFront distribution, static records.

Also, there is a solution for Terragrunt users.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.37 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.37 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | terraform-aws-modules/cloudfront/aws | ~> 3.0 |
| <a name="module_delegation_sets"></a> [delegation\_sets](#module\_delegation\_sets) | ../../modules/delegation-sets | n/a |
| <a name="module_disabled_records"></a> [disabled\_records](#module\_disabled\_records) | ../../modules/records | n/a |
| <a name="module_disabled_resolver_endpoints"></a> [disabled\_resolver\_endpoints](#module\_disabled\_resolver\_endpoints) | ../../modules/resolver-endpoints | n/a |
| <a name="module_records"></a> [records](#module\_records) | ../../modules/records | n/a |
| <a name="module_records_with_full_names"></a> [records\_with\_full\_names](#module\_records\_with\_full\_names) | ../../modules/records | n/a |
| <a name="module_resolver_endpoints"></a> [resolver\_endpoints](#module\_resolver\_endpoints) | ../../modules/resolver-endpoints | n/a |
| <a name="module_resolver_rule_associations"></a> [resolver\_rule\_associations](#module\_resolver\_rule\_associations) | ../../modules/resolver-rule-associations | n/a |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | n/a |
| <a name="module_terragrunt"></a> [terragrunt](#module\_terragrunt) | ../../modules/records | n/a |
| <a name="module_vpc1"></a> [vpc1](#module\_vpc1) | terraform-aws-modules/vpc/aws | ~> 5.0 |
| <a name="module_vpc2"></a> [vpc2](#module\_vpc2) | terraform-aws-modules/vpc/aws | ~> 5.0 |
| <a name="module_zones"></a> [zones](#module\_zones) | ../../modules/zones | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_health_check.failover](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check) | resource |
| [aws_route53_resolver_rule.sys](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_delegation_set_id"></a> [route53\_delegation\_set\_id](#output\_route53\_delegation\_set\_id) | ID of Route53 delegation set |
| <a name="output_route53_delegation_set_name_servers"></a> [route53\_delegation\_set\_name\_servers](#output\_route53\_delegation\_set\_name\_servers) | Name servers in the Route53 delegation set |
| <a name="output_route53_record_fqdn"></a> [route53\_record\_fqdn](#output\_route53\_record\_fqdn) | FQDN built using the zone domain and name |
| <a name="output_route53_record_name"></a> [route53\_record\_name](#output\_route53\_record\_name) | The name of the record |
| <a name="output_route53_resolver_rule_association_id"></a> [route53\_resolver\_rule\_association\_id](#output\_route53\_resolver\_rule\_association\_id) | ID of Route53 Resolver rule associations |
| <a name="output_route53_resolver_rule_association_name"></a> [route53\_resolver\_rule\_association\_name](#output\_route53\_resolver\_rule\_association\_name) | Name of Route53 Resolver rule associations |
| <a name="output_route53_resolver_rule_association_resolver_rule_id"></a> [route53\_resolver\_rule\_association\_resolver\_rule\_id](#output\_route53\_resolver\_rule\_association\_resolver\_rule\_id) | ID of Route53 Resolver rule associations resolver rule |
| <a name="output_route53_static_zone_name"></a> [route53\_static\_zone\_name](#output\_route53\_static\_zone\_name) | Name of Route53 zone created statically to avoid invalid count argument error when creating records and zones simmultaneously |
| <a name="output_route53_zone_name"></a> [route53\_zone\_name](#output\_route53\_zone\_name) | Name of Route53 zone |
| <a name="output_route53_zone_name_servers"></a> [route53\_zone\_name\_servers](#output\_route53\_zone\_name\_servers) | Name servers of Route53 zone |
| <a name="output_route53_zone_zone_arn"></a> [route53\_zone\_zone\_arn](#output\_route53\_zone\_zone\_arn) | Zone ARN of Route53 zone |
| <a name="output_route53_zone_zone_id"></a> [route53\_zone\_zone\_id](#output\_route53\_zone\_zone\_id) | Zone ID of Route53 zone |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
