resource "azurerm_linux_virtual_machine" "vm" {
  count                 = 2
  name                  = "vm-linux-${var.env}-${var.region}"
  location              = azurerm_resource_group.rg.id
  resource_group_name   = azurerm_resource_group.rg.id
  size                  = "Standard_F2"
  admin_username        = sensitive("linux-user")
  network_interface_ids = azurerm_network_interface.nic[count.index]
  custom_data           = filebase64("cloud-init.yml")
  
  admin_ssh_key {
    username   = sensitive("linux-user")
    public_key = var.admin_ssh_key
  }

  os_disk {
    caching                = "ReadWrite"
    storage_account_type   = "Standard_LRS"
  }

  source_image_reference {
    publisher  = "Canonical"
    offer      = "UbuntuServer"
    sku        = "18.04-LTS"
    version    = "latest"
  }
}