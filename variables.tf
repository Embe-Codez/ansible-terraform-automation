variable "env" {
  type = string
}

variable "regions" {
  type = map(object({
    address_space = list(string)
    subnet_prefix = string
    private_ip    = list(string)
    security_rule = map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

variable "admin_ssh_key" {
  type = string
}