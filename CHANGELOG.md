# Changelog

All notable changes to this project will be documented in this file.

## [3.1.0](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v3.0.0...v3.1.0) (2024-06-08)


### Features

* Add resolver-endpoints submodule ([#106](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/106)) ([67b5cf3](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/67b5cf322d4927a0c84e6e20538c05384c940f2b))

## [3.0.0](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.11.1...v3.0.0) (2024-06-08)


### ⚠ BREAKING CHANGES

* Add support for geoproximity routing policy. Upgraded TF version to 1.3.2 (#105)

### Features

* Add support for geoproximity routing policy. Upgraded TF version to 1.3.2 ([#105](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/105)) ([461eef2](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/461eef2a24eac18a513a3f7f6c5993c61cd8c73a))

## [2.11.1](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.11.0...v2.11.1) (2024-03-07)


### Bug Fixes

* Update CI workflow versions to remove deprecated runtime warnings ([#104](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/104)) ([ab3aed7](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/ab3aed78c35c9a48b946f0f9788c2105216f5715))

## [2.11.0](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.10.2...v2.11.0) (2023-12-15)


### Features

* Added static zone name output ([#102](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/102)) ([bc63328](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/bc63328714550fd903d2574b263833c9ce1c867e))

### [2.10.2](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.10.1...v2.10.2) (2023-01-24)


### Bug Fixes

* Use a version for  to avoid GitHub API rate limiting on CI workflows ([#89](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/89)) ([30e4fb9](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/30e4fb96775e435bf7ac959927765b04ed833a86))

### [2.10.1](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.10.0...v2.10.1) (2022-10-27)


### Bug Fixes

* Update CI configuration files to use latest version ([#85](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/85)) ([19169f7](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/19169f767c8383d13b50b942240af03c88c4b676))

## [2.10.0](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.9.0...v2.10.0) (2022-10-20)


### Features

* Add zone ARN to outputs ([#83](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/83)) ([fad41de](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/fad41de41c3036774ddaa0aac07937eb6da448b6))

## [2.9.0](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.8.2...v2.9.0) (2022-06-28)


### Features

* **records:** Add support for latency routing policy ([#76](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/76)) ([206d82c](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/206d82cfdaf958f99dd8faa2c25de1860158d346))

### [2.8.2](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.8.1...v2.8.2) (2022-06-26)


### Bug Fixes

* Fixed for_each in zones submodule ([#74](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/74)) ([68352a6](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/68352a62e5c2dcb57ac3fae2afeff371f75444f8))

### [2.8.1](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.8.0...v2.8.1) (2022-06-19)


### Bug Fixes

* Fixed the for_each value depends on resource attributes that cannot be determined until apply ([#72](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/72)) ([e6fe5ba](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/e6fe5baaaf8a1b6f8f939c6daf9d0729eedce15e))

## [2.8.0](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.7.0...v2.8.0) (2022-05-27)


### Features

* Add resolver rule association module ([#70](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/70)) ([b92e8eb](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/b92e8ebfbeb06c17e1cd3d9bf8f7b4b79a319a25))

## [2.7.0](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.6.0...v2.7.0) (2022-05-27)


### Features

* Added full_override_name override to disable adding domain name to record names ([#69](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/69)) ([553a4e1](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/553a4e180dedf41f652be91a2a8feb7a257b3354))

## [2.6.0](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.5.0...v2.6.0) (2022-03-12)


### Features

* Made it clear that we stand with Ukraine ([6d46086](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/6d4608698f99cf418d9f9d3c535310d6bd703b6e))

# [2.5.0](https://github.com/terraform-aws-modules/terraform-aws-route53/compare/v2.4.0...v2.5.0) (2022-01-06)


### Bug Fixes

* update CI/CD process to enable auto-release workflow ([#62](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/62)) ([563c8b7](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/563c8b79aed34aa71bf34d679ba1be42b69c447a))


### Features

* Added support for delegation sets ([#22](https://github.com/terraform-aws-modules/terraform-aws-route53/issues/22)) ([43f587d](https://github.com/terraform-aws-modules/terraform-aws-route53/commit/43f587d8a304adb5dfc4c22df5191cc2fbae49d0))

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
