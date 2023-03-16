resource "azurerm_network_interface" "nic" {
  count                = 2
  name                 = "nic-${count.index+1}-${var.env}-${var.region}"
  location             = azurerm_resource_group.rg.id
  resource_group_name  = azurerm_resource_group.rg.id

  ip_configuration {
    name                          = "internal-${count.index+1}"
    subnet_id                     = azurerm_virtual_network.vnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = element(var.private_ip, count.index)
  }
}