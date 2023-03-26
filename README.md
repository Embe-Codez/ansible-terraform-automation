# Automating Infrastructure

I originally created this project to only automate the provisioning of infrastructure with Terraform, but have decided to continue adding to this project by incorporating Ansible for configuration management and possibly deploying a basic web app via Docker.

In the end, I hope to have a complete mini infrastructure model that showcases how to provision infrastructure-as-code and configuration-as-code, as well as deploy it to multiple environments (e.g. dev, prod, uat) with repeatable results via a CI/CD (continuous integration/continuous deployment) pipeline. STAY TUNED!

## Terraform

This automation code creates a scalable Azure infrastructure using Terraform to deploy infrastructure in two separate regions (east us and central us) that includes the following:

* Virtual network
    * VNet
    * Subnet
    * NSG rules
* Linux virtual machine
    * Two instances in each region
    * Network interfaces for each instance
* Postgres
    * SQL server
    * Database

### Cloud-Init File

This special file will provision the following services for the virtual machines created during Terraform apply:

* Chrony: This is a network time protocol (NTP) service that helps synchronize the system clock on each of the virtual machines with the same reference clock. This ensures that time-based processes such as logging, scheduled tasks, and database transactions remain consistent across all virtual machines.

* Fail2Ban: This is an intrusion prevention system that scans log files on each virtual machine for signs of suspicious activity, such as failed login attempts or other common attack patterns. When a suspicious pattern is detected, Fail2Ban will automatically block the IP address associated with the suspicious activity, helping to prevent unauthorized access to the virtual machines.

* UFW (Uncomplicated Firewall): This is a firewall service that helps secure network traffic to and from the virtual machines by allowing or blocking incoming and outgoing connections based on a set of predefined rules. This helps to prevent unauthorized access to the virtual machines and ensure that only approved traffic is allowed.

### TFVARS File

You may use a TFVARS file to deploy infrastructure to multiple environments (e.g. dev, uat, prod) for scaling. I have committed a dev.tfvars file as an example, but in an actual environment, you wouldn't version control your TFVARS file if you had secrets within the file itself.
Variables

    The following variables can be set to customize the infrastructure:

* var.region: The regions where the infrastructure should be deployed. Default is ["eastus", "westus"].
* var.env: The environment for the infrastructure (e.g. dev, prod). Default is dev.
* var.admin_ssh_key: The SSH public key for the admin user on the Linux virtual machines. Default is ~/.ssh/id_rsa.pub.
* var.address_space: The address space for the virtual network. Default is "10.0.0.0/16".
* var.subnet_prefix: The subnet prefix for the virtual machines. Default is "10.0.1.0/24".
* var.security_rule: The security rule for the virtual network. Default is "allow_ssh".
* var.private_ip: The private IP address for the virtual machines. Default is ["10.0.1.4", "10.0.1.5"].

## Ansible

An Ansible playbook is used to deploy the following services to the virtual machines that were provisioned with Terraform. Ansible uses an inventory file to organize how these services will be deployed to their respective hosts.

    The following services are deployed:

* Cloudflare for DNS.
* Let's Encrypt for SSL certificates.
* NGINX for a reverse proxy/
* Node.js for the frontend and backend.

    Ansible inventory:

The following inventory structure is used to deploy NGINX and Node.js in a logically to their respective hosts:

* [nginx_servers]
     * vm1
     * vm2

* [nodejs_servers]
     * vm3
     * vm4

## CI/CD Workflow

Continuous Integration and Continuous Deployment

We use GitHub Actions for continuous integration and Argo for continuous deployment. The pipeline tests for functionality, validates that secrets are valid, and includes error handling.

### GitHub Actions

The GitHub Actions workflow for continuous integration is triggered on every pull request and on every push to the main branch. The workflow includes the following steps:

* Install Terraform and Terragrunt.
* Validate the Terraform code syntax.
* Format the Terraform code using terraform fmt.
* Install any required Terraform plugins.
* Initialize the Terraform backend.
* Plan the Terraform infrastructure changes and store the plan in a file.
* Verify that required secrets are set.
* Upload the plan file as an artifact.

### Argo Workflow

The Argo workflow for continuous deployment is triggered when a new artifact is uploaded by the GitHub Actions workflow. The workflow includes the following steps:

* Deploy the Terraform infrastructure using the plan file uploaded by the GitHub Actions workflow.
* Verify that the infrastructure was deployed successfully.
* end a notification to a Slack channel when the deployment is successful.

## Usage

To use this Terraform code, follow these steps:

1. Clone this repository to your local machine.
2. Install Terraform and Terragrunt.
3. Set the required environment variables for your Azure subscription and Slack webhook URL.
4. Run the following command to deploy the infrastructure:

``` cd resources ```
``` terragrunt apply-all ```

This will deploy the infrastructure in all regions specified in the region variable.

To destroy the infrastructure, run the following command:

``` cd resources ```
``` terragrunt destroy-all ```

This will destroy the infrastructure in all regions specified in the region variable. Note that this will delete all data stored in the Postgres database and SQL server, so use with caution.