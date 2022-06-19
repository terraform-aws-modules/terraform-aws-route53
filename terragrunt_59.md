# Notes for issue 59 and PR 72

https://github.com/terraform-aws-modules/terraform-aws-route53/pull/72
https://github.com/terraform-aws-modules/terraform-aws-route53/pull/64

```
########################################################################################
# IF YOU ARE READING THIS AND WANT TO TRY FIXING IT, PLEASE INCREASE THE COUNTER BELOW!
########################################################################################
# number_of_hours_spent_on_issue_59 = 22
########################################################################################
```

## Here is the short explanation of the problem.
This module can be called by TF and TG, so it has to support these 3 cases:
1. Terraform with "known values" (static values)
2. Terraform with "(known after apply)" (module.s3_bucket, module.cloudfront, etc)
3. Terragrunt with "known values" - (TG always resolves values before calling Terraform). TG wraps values with `jsonencode()`.
4. Terragrunt with "unknown values"/"(known after apply)" - this is not possible with TG.

## Considerations:

1. Try not to change variable types very much. `type = any` is prefered.
2. Keep in mind different behaviour when `records` has different length, `records` or/and `alias` is specified.
3. The same name of resources (aws_route53_record.this) should be used for both TF and TG.
4. If necessary, use Terraform 1.0 as a minimum version (not newer). Terraform 0.13 can be a history, if necessary for this fix to work.

## Success criteria:

1. `terraform apply` in `examples/complete` should work without `-target`
2. `records` should include records, alias, references to `module.s3_bucket` in `name`.
3. At least, modules `zones`, `records`, and `terragrunt` should be enabled (not commented)
