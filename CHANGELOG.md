## [unreleased]

### 🚀 Features

- *(snowflake-warehouse)* Support multiple warehouses via map configuration
- Clean up legacy configurations and update CI workflows
- [**breaking**] Add blank line for improved readability in main.tf
- Update CI workflow to use snowflake-warehouse module and clean up main.tf

### 🐛 Bug Fixes

- *(snowflake)* Update JWT authenticator to SNOWFLAKE_JWT and remove extra blank line
- *(release)* Force patch release
- *(release)* Trigger semantic release

### 🚜 Refactor

- Restructure project to modular Terraform architecture
- *(test)* Migrate to gosnowflake config builder for JWT authentication
- *(test)* Improve warehouse property fetching and remove extra blank line

### 📚 Documentation

- *(readme)* Update badges to reflect Snowflake focus
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]

### 🎨 Styling

- *(snowflake-warehouse)* Add periods to output descriptions
- *(snowflake-warehouse)* Add blank line after module header comment

### ⚙️ Miscellaneous Tasks

- *(github-actions)* Add permissions and token for changelog generation
- *(release)* Version 1.0.0 [skip ci]
- *(testing)* Migrate from Jest to Terratest and restructure examples
- *(github-actions)* Migrate authentication to key-pair and remove property tests
- *(github-actions)* Enhance Terratest output visibility and remove conditional gate
- *(test)* Update Go dependencies and add go.sum
- *(testing)* Migrate to key-pair authentication and add go mod tidy
- *(github-actions)* Add pipefail option to Terratest commands and update Snowflake provider source
- *(release)* Version 1.0.1 [skip ci]
