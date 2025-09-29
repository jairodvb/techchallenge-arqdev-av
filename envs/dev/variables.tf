variable "resource_group_name" {
  type        = string
  description = "Nombre del resource group"
  default     = "rg-dev"
}

variable "location" {
  type        = string
  description = "Región de Azure"
  default     = "eastus2"
}

variable "vnet_name" {
  type        = string
  description = "Nombre de la VNet"
  default     = "vnet-dev"
}

variable "vnet_address_space" {
  type        = string
  description = "CIDR para la VNet"
  default     = "10.0.0.0/16"
}

variable "appgw_subnet_prefix" {
  type        = string
  description = "CIDR para subnet del Application Gateway"
  default     = "10.0.1.0/24"
}

variable "vmss_subnet_prefix" {
  type        = string
  description = "CIDR para subnet del VMSS"
  default     = "10.0.2.0/24"
}

variable "vmss_name" {
  type        = string
  description = "Nombre del Virtual Machine Scale Set"
  default     = "vmss-dev"
}

variable "vm_size" {
  type        = string
  description = "Tamaño de las máquinas virtuales"
  default     = "Standard_B2s"
}

variable "instance_count" {
  type        = number
  description = "Cantidad inicial de instancias en el VMSS"
  default     = 2
}

variable "admin_username" {
  type        = string
  description = "Usuario administrador de las VMs"
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Ruta a la llave pública SSH"
  default     = "~/.ssh/id_rsa.pub"
}
