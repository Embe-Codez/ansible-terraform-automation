# Changelog

## 1.0.1 (2023-03-22)
Added
    * Updated README.md
    * Added LICENSE file
    * Added variables to authenticate with Azure provider
          * subscription_id = var.subscription_id
          * client_id       = var.client_id
          * client_secret   = var.client_secret
          * tenant_id       = var.tenant_id

Changed
    * Modified README.md file

## 1.0.0 (2023-03-16)
Added

    * Initial infrastructure code with modules and variables
    * Continuous integration and deployment pipeline with GitHub Actions and Argo
    * Terraform plan validation and functionality tests
    * Verification of required secrets before deployment
    * Slack notification on successful deployment