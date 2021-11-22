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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.49 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.49 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | terraform-aws-modules/cloudfront/aws | n/a |
| <a name="module_disabled_records"></a> [disabled\_records](#module\_disabled\_records) | ../../modules/records | n/a |
| <a name="module_records"></a> [records](#module\_records) | ../../modules/records | n/a |
| <a name="module_records_with_lists"></a> [records\_with\_lists](#module\_records\_with\_lists) | ../../modules/records | n/a |
| <a name="module_records_with_terragrunt"></a> [records\_with\_terragrunt](#module\_records\_with\_terragrunt) | ../../modules/records | n/a |
| <a name="module_records_with_terragrunt_with_lists"></a> [records\_with\_terragrunt\_with\_lists](#module\_records\_with\_terragrunt\_with\_lists) | ../../modules/records | n/a |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |
| <a name="module_vpc2"></a> [vpc2](#module\_vpc2) | terraform-aws-modules/vpc/aws | n/a |
| <a name="module_zones"></a> [zones](#module\_zones) | ../../modules/zones | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_health_check.failover](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_record_fqdn"></a> [route53\_record\_fqdn](#output\_route53\_record\_fqdn) | FQDN built using the zone domain and name |
| <a name="output_route53_record_name"></a> [route53\_record\_name](#output\_route53\_record\_name) | The name of the record |
| <a name="output_route53_zone_name"></a> [route53\_zone\_name](#output\_route53\_zone\_name) | Name of Route53 zone |
| <a name="output_route53_zone_name_servers"></a> [route53\_zone\_name\_servers](#output\_route53\_zone\_name\_servers) | Name servers of Route53 zone |
| <a name="output_route53_zone_zone_id"></a> [route53\_zone\_zone\_id](#output\_route53\_zone\_zone\_id) | Zone ID of Route53 zone |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
