# Changelog

## 1.0.3 (2023-03-26)
### Added:
* Created CI / CD pipelines for Ansible and Terraform each.

### Changed:
* Updated README.md file to reflect pipeline configuration.

### Removed:
* Removed Argo CD pipeline for Ansible and Terraform each.

## 1.0.2 (2023-03-26)
### Added:
* Ansible playbook for virtual machine configuration to:
    * Configure DNS records using Cloudflare.
    * Generate SSL certificates for virtual machines.
    * Deploy NGINX as a reverse proxy.
    * Deploy Node.js for the frontend and backend.

### Changed:
* Updated README.md file.
* Updated clout-init.yml to:
    * Disable root login.
    * Allow UFW to open ports 80 and 443.
    * Create service account for Ansible playbook.

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