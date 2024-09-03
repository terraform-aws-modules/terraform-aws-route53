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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.56 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.r53_owner"></a> [aws.r53\_owner](#provider\_aws.r53\_owner) | >= 3.56 |
| <a name="provider_aws.vpc_owner"></a> [aws.vpc\_owner](#provider\_aws.vpc\_owner) | >= 3.56 |

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
| <a name="input_create"></a> [create](#input\_create) | Whether to create Route53 Zone associations | `bool` | `true` | no |
| <a name="input_zone_vpc_associations"></a> [zone\_vpc\_associations](#input\_zone\_vpc\_associations) | Map of associations indicating zone\_id and vpc\_id to associate. | <pre>map(object({<br>    zone_id    = string<br>    vpc_id     = string<br>    vpc_region = optional(string)<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_route53_vpc_association_authorization_id"></a> [aws\_route53\_vpc\_association\_authorization\_id](#output\_aws\_route53\_vpc\_association\_authorization\_id) | ID of Route53 VPC association authorizations |
| <a name="output_aws_route53_zone_association_id"></a> [aws\_route53\_zone\_association\_id](#output\_aws\_route53\_zone\_association\_id) | ID of Route53 VPC association |
| <a name="output_aws_route53_zone_association_owning_account"></a> [aws\_route53\_zone\_association\_owning\_account](#output\_aws\_route53\_zone\_association\_owning\_account) | The account ID of the account that created the hosted zone. |
<!-- END_TF_DOCS -->
