# Terraform Infrastructure:

This Terraform code creates a scalable infrastructure that includes a virtual network, two Linux virtual machines in one subnet, two network interfaces for the virtual machines, one Postgres database, one SQL server, and NSG security rules to secure network traffic within the network. The module utilizes a vars.region variable to deploy this infrastructure in two separate regions for high availability.

# CLOUD-INIT File:
This special file will provision the following services for the virtual machines created during Terraform apply:

    1. Chrony: This is a network time protocol (NTP) service that helps synchronize the system clock on each of the virtual machines with the same reference clock. This ensures that time-based processes such as logging, scheduled tasks, and database transactions remain consistent across all virtual machines.

    2. Fail2Ban: This is an intrusion prevention system that scans log files on each virtual machine for signs of suspicious activity, such as failed login attempts or other common attack patterns. When a suspicious pattern is detected, Fail2Ban will automatically block the IP address associated with the suspicious activity, helping to prevent unauthorized access to the virtual machines.

    3. UFW (Uncomplicated Firewall): This is a firewall service that helps secure network traffic to and from the virtual machines by allowing or blocking incoming and outgoing connections based on a set of predefined rules. This helps to prevent unauthorized access to the virtual machines and ensure that only approved traffic is allowed.

# TFVARS File

You may use a TFVARS file to deploy infrastructure to multiple environments (e.g. dev, uat, prod) for scaling. I have committed a dev.tfvars file as an example, but in an actual environment, you wouldn't version control your TFVARS file if you had secrets within the file itself.

# Continuous Integration and Continuous Deployment

We use GitHub Actions for continuous integration and Argo for continuous deployment. The pipeline tests for functionality, validates that secrets are valid, and includes error handling.

# GitHub Actions

The GitHub Actions workflow for continuous integration is triggered on every pull request and on every push to the main branch. The workflow includes the following steps:

    Install Terraform and Terragrunt
    Validate the Terraform code syntax
    Format the Terraform code using terraform fmt
    Install any required Terraform plugins
    Initialize the Terraform backend
    Plan the Terraform infrastructure changes and store the plan in a file
    Verify that required secrets are set
    Upload the plan file as an artifact

# Argo Workflow

The Argo workflow for continuous deployment is triggered when a new artifact is uploaded by the GitHub Actions workflow. The workflow includes the following steps:

    Deploy the Terraform infrastructure using the plan file uploaded by the GitHub Actions workflow
    Verify that the infrastructure was deployed successfully
    Send a notification to a Slack channel when the deployment is successful

# Usage

To use this Terraform code, follow these steps:

    1. Clone this repository to your local machine.

    2. Install Terraform and Terragrunt.

    3. Set the required environment variables for your Azure subscription and Slack webhook URL.

    4. Run the following command to deploy the infrastructure:
        
        `cd resources`
        `terragrunt apply-all`

This will deploy the infrastructure in all regions specified in the var.region variable.

To destroy the infrastructure, run the following command:

    `cd resources`
    `terragrunt destroy-all`

    This will destroy the infrastructure in all regions specified in the var.region variable. Note that this will delete all data stored in the Postgres database and SQL server, so use with caution.

# Variables

The following variables can be set to customize the infrastructure:

    var.region: The regions where the infrastructure should be deployed. Default is ["eastus", "westus"].
    var.env: The environment for the infrastructure (e.g. dev, prod). Default is dev.
    var.admin_ssh_key: The SSH public key for the admin user on the Linux virtual machines. Default is ~/.ssh/id_rsa.pub.
    var.address_space: The address space for the virtual network. Default is "10.0.0.0/16".
    var.subnet_prefix: The subnet prefix for the virtual machines. Default is "10.0.1.0/24".
    var.security_rule: The security rule for the virtual network. Default is "allow_ssh".
    var.private_ip: The private IP address for the virtual machines. Default is ["10.0.1.4", "10.0.1.5"].

Note that some variables may require sensitive information, such as credentials