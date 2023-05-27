# Automating Application & Infrastructure Deployment

This project aims to automate the provisioning of infrastructure using Terraform, implement configuration management with Ansible, and enable continuous integration and deployment through a GitHub Actions CI/CD pipeline.

## Terraform

The Terraform code in this repository creates a scalable Azure infrastructure with the following components:

    - Virtual network
        - VNet
        - Subnet
        - NSG rules
    - Linux virtual machine
        - Multiple instances across different regions
        - Network interfaces for each instance
    - Postgres
        - SQL server
        - Database

### Cloud-Init File

The cloud-init file provisions additional services on the virtual machines created by Terraform. It includes:

    - Chrony: Network time protocol (NTP) service for time synchronization.
    - Fail2Ban: Intrusion prevention system that scans log files for suspicious activity.
    - UFW (Uncomplicated Firewall): Firewall service for securing network traffic.

## Ansible

The Ansible playbook deploys various services to the virtual machines provisioned by Terraform. The deployed services include:

    - Cloudflare for DNS
    - Let's Encrypt for SSL certificates
    - NGINX as a reverse proxy
    - Node.js for frontend and backend

The Ansible inventory organizes the deployment of services to their respective hosts.

```

[all]
vm1 ansible_host=10.0.1.40
vm2 ansible_host=10.0.1.50
vm3 ansible_host=10.1.2.40
vm4 ansible_host=10.1.2.50

[nginx_servers]
vm1
vm2

[nodejs_servers]
vm3
vm4

```

## CI/CD Workflow:

The CI/CD pipeline uses GitHub Actions for continuous integration and deployment. It consists of the following steps:

### Terraform CI / CD: (terraform/.github/workflows/pipeline.yml)

    - Install Terraform.
    - Initialize the Terraform backend.
    - Validate Terraform code syntax.
    - Format Terraform code using terraform fmt.
    - Install required Terraform plugins.
    - Plan Terraform infrastructure changes and store the plan as an artifact.
    - Verify that required secrets are set.
    - Deploy to dev environment.

### Ansible CI / CD: (ansible/.github/workflows/pipeline.yml)

    - Install Ansible
    - Validate Ansible playbook syntax
    - Check that Ansible playbook runs without making changes
    - Apply the Ansible playbook to the development environment