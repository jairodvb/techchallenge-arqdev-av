module "network" {
  source              = "../../modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  appgw_subnet_prefix = var.appgw_subnet_prefix
  vmss_subnet_prefix  = var.vmss_subnet_prefix
}

module "lb" {
  source              = "../../modules/lb"
  resource_group_name = module.network.resource_group_name
  location            = var.location
}

module "vmss" {
  source              = "../../modules/vmss"
  vmss_name           = var.vmss_name
  resource_group_name = module.network.resource_group_name
  location            = var.location
  vm_size             = var.vm_size
  instance_count      = var.instance_count
  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
  subnet_id           = module.network.vmss_subnet_id

  backend_address_pool_id = module.lb.backend_address_pool_id
}

module "autoscale" {
  source              = "../../modules/autoscale"
  autoscale_name      = "${var.vmss_name}-autoscale"
  location            = var.location
  resource_group_name = module.network.resource_group_name
  target_resource_id  = module.vmss.vmss_id
}
