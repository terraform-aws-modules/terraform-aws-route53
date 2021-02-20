# Route53 zones and records example

Configuration in this directory creates Route53 zones and records for various types of resources - S3 bucket, CloudFront distribution, static records.

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
| terraform | >= 0.12.6 |
| aws | >= 2.49 |

## Providers

No provider.

## Modules

| Name | Source | Version |
|------|--------|---------|
| cloudfront | terraform-aws-modules/cloudfront/aws |  |
| disabled_records | ../../modules/records |  |
| records | ../../modules/records |  |
| s3_bucket | terraform-aws-modules/s3-bucket/aws |  |
| vpc | terraform-aws-modules/vpc/aws |  |
| vpc2 | terraform-aws-modules/vpc/aws |  |
| zones | ../../modules/zones |  |

## Resources

No resources.

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| this\_route53\_record\_fqdn | FQDN built using the zone domain and name |
| this\_route53\_record\_name | The name of the record |
| this\_route53\_zone\_name | Name of Route53 zone |
| this\_route53\_zone\_name\_servers | Name servers of Route53 zone |
| this\_route53\_zone\_zone\_id | Zone ID of Route53 zone |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
