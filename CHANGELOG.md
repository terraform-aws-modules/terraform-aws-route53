# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]



<a name="v2.4.0"></a>
## [v2.4.0] - 2021-11-11

- chore: Updated example with AAAA records for dual-stack CloudFront ([#60](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/60))


<a name="v2.3.0"></a>
## [v2.3.0] - 2021-08-27

- fix: Fixed records with different length ([#54](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/54))
- feat: Allow zones with the same domain name (eg, public and private) ([#55](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/55))


<a name="v2.2.0"></a>
## [v2.2.0] - 2021-08-13

- feat: Add geo routing policy and multivalue answer routing policy ([#52](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/52))
- feat: Add option to overwrite existing records ([#43](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/43))


<a name="v2.1.0"></a>
## [v2.1.0] - 2021-06-11

- feat: Added fix for records with terragrunt ([#42](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/42))
- chore: update CI/CD to use stable `terraform-docs` release artifact and discoverable Apache2.0 license ([#38](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/38))
- chore: Updated versions in README ([#37](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/37))


<a name="v2.0.0"></a>
## [v2.0.0] - 2021-04-26

- feat: Shorten outputs (removing this_) ([#36](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/36))


<a name="v1.11.0"></a>
## [v1.11.0] - 2021-04-21

- feat: Add ability for users to create aliases in the same zone ([#35](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/35))


<a name="v1.10.0"></a>
## [v1.10.0] - 2021-04-13

- feat: Add support for failover_routing_policy and health_check_id ([#33](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/33))
- chore: update documentation and pin `terraform_docs` version to avoid future changes ([#32](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/32))
- fix: correct documentation based on update by `terraform_docs` ([#31](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/31))
- chore: add ci-cd workflow for pre-commit checks ([#30](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/30))


<a name="v1.9.0"></a>
## [v1.9.0] - 2021-02-20

- chore: update documentation based on latest `terraform-docs` which includes module and resource sections ([#28](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/28))


<a name="v1.8.0"></a>
## [v1.8.0] - 2021-02-14

- feat: Add support for multiple VPCs when creating private hosted zones ([#27](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/27))


<a name="v1.7.0"></a>
## [v1.7.0] - 2021-02-14

- feat: add global tags variable to zones ([#26](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/26))


<a name="v1.6.0"></a>
## [v1.6.0] - 2021-01-15

- feat: added weighted routing policy ([#23](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/23))


<a name="v1.5.0"></a>
## [v1.5.0] - 2020-11-27

- fix: use tomap() instead of type declaration object() ([#14](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/14))


<a name="v1.4.0"></a>
## [v1.4.0] - 2020-11-27

- feat: Adding dynamic vpc block to handle private zones ([#13](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/13))


<a name="v1.3.0"></a>
## [v1.3.0] - 2020-11-24

- fix: Updated supported Terraform versions ([#18](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/18))


<a name="v1.2.0"></a>
## [v1.2.0] - 2020-09-23

- fix: Allow combining records and aliases ([#11](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/11))


<a name="v1.1.0"></a>
## [v1.1.0] - 2020-08-13

- Updated version requirements for AWS provider v3


<a name="v0.1.0"></a>
## [v0.1.0] - 2020-06-17



<a name="v1.0.0"></a>
## v1.0.0 - 2020-06-17

- Added route53 modules for zones and records


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.4.0...HEAD
[v2.4.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.3.0...v2.4.0
[v2.3.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.2.0...v2.3.0
[v2.2.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.1.0...v2.2.0
[v2.1.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.0.0...v2.1.0
[v2.0.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v1.11.0...v2.0.0
[v1.11.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v1.10.0...v1.11.0
[v1.10.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v1.9.0...v1.10.0
[v1.9.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v1.8.0...v1.9.0
[v1.8.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v1.7.0...v1.8.0
[v1.7.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v1.6.0...v1.7.0
[v1.6.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v1.5.0...v1.6.0
[v1.5.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v1.4.0...v1.5.0
[v1.4.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v1.3.0...v1.4.0
[v1.3.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v1.2.0...v1.3.0
[v1.2.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v1.1.0...v1.2.0
[v1.1.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v0.1.0...v1.1.0
[v0.1.0]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v1.0.0...v0.1.0
