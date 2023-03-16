resource "azurerm_virtual_network" "vnet" {
  name                 = "vnet-${var.env}-${var.region}"
  location             = azurerm_resource_group.rg.id
  resource_group_name  = azurerm_resource_group.rg.id
  address_space        = var.address_space

  subnet {
    name               = "snet-${var.env}-${var.region}"
    address_prefix     = var.subnet_prefix
  }
}

resource "azurerm_network_security_group" "vnet" {
  name                        = "nsg-${var.env}-${var.region}"
  resource_group_name         = azurerm_resource_group.rg.id
  location                    = azurerm_resource_group.rg.id
}

resource "azurerm_network_security_rule" "vnet" {
  count = length(var.security_rule)
  name                        = var.security_rule[count.index].name
  priority                    = var.security_rule[count.index].priority
  direction                   = var.security_rule[count.index].direction
  access                      = var.security_rule[count.index].access
  protocol                    = var.security_rule[count.index].protocol
  source_port_range           = var.security_rule[count.index].source_port_range
  destination_port_range      = var.security_rule[count.index].destination_port_range
  source_address_prefix       = var.security_rule[count.index].source_address_prefix
  destination_address_prefix  = var.security_rule[count.index].destination_address_prefix
  resource_group_name         = azurerm_resource_group.rg.id
  network_security_group_name = azurerm_network_security_group.vnet.id
}
