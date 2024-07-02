# Route53 Zone cross-account VPC association

This module creates cross-account Route53 Zone associations.

It does need two providers to be passed to handle both AWS accounts:
- `aws.r53_owner`: Account owning the Route53 zones to make the cross-account association authorization
- `aws.vpc_owner`: Account owning the VPCs to associate with the Route53 zones

Many-to-many associations are possible, using the zone_vpc_associations input variable.

## Usage

### Create Route53 Zone cross-account VPC association

```hcl
module "zone_cross_account_vpc_association" {
  source = "terraform-aws-modules/route53/aws//modules/zone-cross-account-vpc-association"
  version = "~> 3.2"
  providers = {
    aws.r53_owner = aws
    aws.vpc_owner = aws.second_account
  }

  zone_vpc_associations = {
    example = {
      zone_id = "Z111111QQQQQQQ"
      vpc_id  = "vpc-185a3e2f2d6d2c863"
    },
    example2 = {
      zone_id    = "Z222222VVVVVVV"
      vpc_id     = "vpc-123456789abcd1234"
      vpc_region = "us-east-2"
    },
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
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
| [aws_route53_vpc_association_authorization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_vpc_association_authorization) | resource |
| [aws_route53_zone_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create Route53 Resolver rule associations | `bool` | `true` | no |
| <a name="input_zone_vpc_associations"></a> [input\_zone\_vpc\_associations](#zone\_vpc\_association) | Map of associations indicating zone_id and vpc_id to associate. | `map(object)` | `{}` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_vpc_association_authorization_id"></a> [route53\_vpc\_association\_authorization\_id](#output\_route53\_vpc\_association\_authorization\_id) | Unique ID of Route53 VPC association authorizations |
| <a name="output_aws_route53_zone_association_id"></a> [route53\_zone\_association\_id](#output\_route53\_zone\_association\_id) | Unique ID of Route53 zone association |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
