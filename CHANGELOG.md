# Changelog

## [0.1.3](https://github.com/saltstack-formulas/rspamd-formula/compare/v0.1.2...v0.1.3) (2021-05-03)


### Continuous Integration

* **commitlint:** ensure `upstream/master` uses main repo URL [skip ci] ([5034c7a](https://github.com/saltstack-formulas/rspamd-formula/commit/5034c7a0702acc4e1865b9c01789701a68746af1))
* **gemfile+lock:** use `ssf` customised `kitchen-docker` repo [skip ci] ([470706c](https://github.com/saltstack-formulas/rspamd-formula/commit/470706c8b0ac8cd08cf811e48cf4486840cb7eef))
* **gitlab-ci:** add `rubocop` linter (with `allow_failure`) [skip ci] ([bb3f7f9](https://github.com/saltstack-formulas/rspamd-formula/commit/bb3f7f902adbe4acc6f5681ec39aca6fad9ac9de))
* **gitlab-ci:** use GitLab CI as Travis CI replacement ([d38bd0a](https://github.com/saltstack-formulas/rspamd-formula/commit/d38bd0a6244685d1743b76276db1bec34b650529))
* **kitchen+ci:** use latest pre-salted images (after CVE) [skip ci] ([44ef649](https://github.com/saltstack-formulas/rspamd-formula/commit/44ef6491cccde03cfdaf758671b9460992a9c185))
* **kitchen+gitlab:** adjust matrix to add `3003` [skip ci] ([17723bc](https://github.com/saltstack-formulas/rspamd-formula/commit/17723bc3c18c159a8732718d9d0729f9f37f733a))
* **kitchen+gitlab-ci:** use latest pre-salted images [skip ci] ([c5e085c](https://github.com/saltstack-formulas/rspamd-formula/commit/c5e085c4a965700f332f7919c7d20899c121d9b5))
* **pre-commit:** update hook for `rubocop` [skip ci] ([0351ab9](https://github.com/saltstack-formulas/rspamd-formula/commit/0351ab9b7c7c304972abdbede6ac224c310435fd))


### Documentation

* **pillar:** fix `manage_redis` documentation ([382db22](https://github.com/saltstack-formulas/rspamd-formula/commit/382db226b0599346d3d08ffcc3eced65df6e0f08))


### Tests

* standardise use of `share` suite & `_mapdata` state [skip ci] ([9156f44](https://github.com/saltstack-formulas/rspamd-formula/commit/9156f444928d1c4726cfd48443104632625a7423))

## [0.1.2](https://github.com/saltstack-formulas/rspamd-formula/compare/v0.1.1...v0.1.2) (2020-10-14)


### Continuous Integration

* **pre-commit:** add to formula [skip ci] ([22b0741](https://github.com/saltstack-formulas/rspamd-formula/commit/22b0741c8d30c3d9b471b87357c8b28761dd0448))
* **pre-commit:** enable/disable `rstcheck` as relevant [skip ci] ([33d6050](https://github.com/saltstack-formulas/rspamd-formula/commit/33d6050ab66a80631dc0eb82b927d01723b2f6ae))
* **pre-commit:** finalise `rstcheck` configuration [skip ci] ([b7bc9ee](https://github.com/saltstack-formulas/rspamd-formula/commit/b7bc9ee560f58c6166af7fd54f363ced1249d128))


### Documentation

* **pillar.exemple:** use_upstream_repo ([624c287](https://github.com/saltstack-formulas/rspamd-formula/commit/624c2875f54958c4dfe22c3ce3cb196c5300ebde))
* **readme:** fix `rstcheck` violation [skip ci] ([cd12451](https://github.com/saltstack-formulas/rspamd-formula/commit/cd124511084f0059c176826cae29bbc6b04ccfe4)), closes [/travis-ci.org/github/myii/rspamd-formula/builds/731608390#L259](https://github.com//travis-ci.org/github/myii/rspamd-formula/builds/731608390/issues/L259)

## [0.1.1](https://github.com/saltstack-formulas/rspamd-formula/compare/v0.1.0...v0.1.1) (2020-08-25)


### Bug Fixes

* **config:** create missing dirs ([51ae696](https://github.com/saltstack-formulas/rspamd-formula/commit/51ae696675204b9075c495294908822a24da4a2c))


### Code Refactoring

* **defaults:** reorganize redis params ([a0060ff](https://github.com/saltstack-formulas/rspamd-formula/commit/a0060ff4f4daed88c796c2c5a14c798393610a62))
* **semantic-release:** align to template-formula ([46bfe11](https://github.com/saltstack-formulas/rspamd-formula/commit/46bfe11337c1239d16e20d8fcf1ce1517bd5b235))


### Continuous Integration

* **travis:** change platforms [skip ci] ([c7ed4aa](https://github.com/saltstack-formulas/rspamd-formula/commit/c7ed4aa683d6430fd6cc6cdb810bae1e56ee7fc3))


### Styles

* **config:** remove empty lines ([04401a1](https://github.com/saltstack-formulas/rspamd-formula/commit/04401a1fdd6b89f086bb07939c320a6c0b9d0166))
