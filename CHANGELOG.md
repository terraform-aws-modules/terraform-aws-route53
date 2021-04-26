# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]



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

- Merge pull request [#7](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/7) from terraform-aws-modules/terraform-provider-githubfile-1592425508189276000
- [ci skip] Create "Makefile".
- Merge pull request [#5](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/5) from terraform-aws-modules/terraform-provider-githubfile-1592425468664303000
- Merge pull request [#2](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/2) from terraform-aws-modules/terraform-provider-githubfile-1592425468664875000
- Merge pull request [#6](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/6) from terraform-aws-modules/terraform-provider-githubfile-1592425468664768000
- Merge pull request [#3](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/3) from terraform-aws-modules/terraform-provider-githubfile-1592425468664901000
- Merge pull request [#1](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/1) from terraform-aws-modules/terraform-provider-githubfile-1592425468664920000
- [ci skip] Create ".pre-commit-config.yaml".
- [ci skip] Create "LICENSE".
- [ci skip] Create ".chglog/CHANGELOG.tpl.md".
- [ci skip] Create ".gitignore".
- [ci skip] Create ".editorconfig".
- Added route53 modules for zones and records


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.0.0...HEAD
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
