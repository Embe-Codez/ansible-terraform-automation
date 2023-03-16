env = "dev"

regions = {

  eastus = {
    address_space = ["10.0.0.0/16"]
    subnet_prefix = "10.0.1.0/24"
    private_ip    = ["10.0.1.40", "10.0.1.50"]
    security_rule = {

      ssh = {
        name                       = "ssh"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },

      postgres = {
        name                       = "postgres"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "5433"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }


  centralus = {

    address_space = ["10.1.0.0/16"]
    subnet_prefix = "10.1.2.0/24"
    private_ip    = ["10.1.2.40", "10.1.2.50"]
    security_rule = {

      ssh = {
        name                       = "ssh"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      postgres = {
        name                       = "postgres"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "5433"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
}