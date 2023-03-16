variable "env" {
  type = string
}

variable "region" {
    type = string
}

variable "address_space" {
  type    = list(string)
}

variable "subnet_prefix" {
    type  = string
}

variable "security_rule" {
  type = map(object({
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
}

variable "admin_ssh_key" {
    type  = string
}

variable "private_ip" {
  type    = list(string)
}