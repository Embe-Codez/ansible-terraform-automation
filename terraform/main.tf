terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

module "infrastructure" {
  for_each      = var.regions
  source        = "./resources"
  env           = var.env
  region        = each.key
  address_space = each.value.address_space
  subnet_prefix = each.value.subnet_prefix
  security_rule = each.value.security_rule
  private_ip    = each.value.private_ip
  admin_ssh_key = var.admin_ssh_key
}