resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = var.vmss_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vm_size
  instances           = var.instance_count
  upgrade_mode        = "Automatic"

  admin_username = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "nic"
    primary = true

  ip_configuration {
    name      = "internal"
    subnet_id = var.subnet_id

    load_balancer_backend_address_pool_ids = var.backend_address_pool_id != null ? [var.backend_address_pool_id] : []

  }

  }

  custom_data = base64encode(file("${path.module}/cloud-init.yaml"))
}
