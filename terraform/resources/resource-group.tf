resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.env}-${var.region}"
  location = var.region
}