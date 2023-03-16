#!/bin/bash

# Set environment variables
export ARM_CLIENT_ID=$(cat ./secrets/ARM_CLIENT_ID)
export ARM_CLIENT_SECRET=$(cat ./secrets/ARM_CLIENT_SECRET)
export ARM_SUBSCRIPTION_ID=$(cat ./secrets/ARM_SUBSCRIPTION_ID)
export ARM_TENANT_ID=$(cat ./secrets/ARM_TENANT_ID)
export ADMIN_SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
export SLACK_WEBHOOK_URL=$(cat ./secrets/SLACK_WEBHOOK_URL)

# Verify secrets are set
if [[ -z "${ARM_CLIENT_ID}" ]]; then
  echo "ARM_CLIENT_ID is not set"
  exit 1
fi
if [[ -z "${ARM_CLIENT_SECRET}" ]]; then
  echo "ARM_CLIENT_SECRET is not set"
  exit 1
fi
if [[ -z "${ARM_SUBSCRIPTION_ID}" ]]; then
  echo "ARM_SUBSCRIPTION_ID is not set"
  exit 1
fi
if [[ -z "${ARM_TENANT_ID}" ]]; then
  echo "ARM_TENANT_ID is not set"
  exit 1
fi
if [[ -z "${ADMIN_SSH_KEY}" ]]; then
  echo "ADMIN_SSH_KEY is not set"
  exit 1
fi
if [[ -z "${SLACK_WEBHOOK_URL}" ]]; then
  echo "SLACK_WEBHOOK_URL is not set"
  exit 1
fi

# Deploy Terraform code
cd resources
terraform init
terraform validate
terraform plan -out=tfplan -input=false
terraform apply -input=false -auto-approve tfplan

# Send notification
curl -d '{"text":"Terraform deployment successful"}' -H 'Content-Type: application/json' -X POST ${SLACK_WEBHOOK_URL}