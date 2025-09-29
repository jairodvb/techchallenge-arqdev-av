variable "vmss_name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "vm_size" { type = string }
variable "instance_count" { type = number }
variable "admin_username" { type = string }
variable "ssh_public_key_path" { type = string }
variable "subnet_id" { type = string }
variable "backend_address_pool_id" {
  type        = string
  description = "ID del backend address pool del Load Balancer"
  default     = null
}