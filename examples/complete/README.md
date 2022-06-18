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

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_disabled_records"></a> [disabled\_records](#module\_disabled\_records) | ../../modules/records | n/a |
| <a name="module_records"></a> [records](#module\_records) | ../../modules/records | n/a |
| <a name="module_records_with_full_names"></a> [records\_with\_full\_names](#module\_records\_with\_full\_names) | ../../modules/records | n/a |
| <a name="module_records_with_lists"></a> [records\_with\_lists](#module\_records\_with\_lists) | ../../modules/records | n/a |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | n/a |
| <a name="module_zones"></a> [zones](#module\_zones) | ../../modules/zones | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
