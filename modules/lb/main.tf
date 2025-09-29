resource "azurerm_public_ip" "lb_pip" {
  name                = "lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "vmss_lb" {
  name                = "vmss-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicFrontend"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "bepool" {
  loadbalancer_id = azurerm_lb.vmss_lb.id
  name            = "BackEndPool"
}

resource "azurerm_lb_probe" "http_probe" {
  loadbalancer_id = azurerm_lb.vmss_lb.id
  name            = "http-probe"
  protocol        = "Tcp"
  port            = 80
}

resource "azurerm_lb_rule" "http_rule" {
  loadbalancer_id                = azurerm_lb.vmss_lb.id
  name                           = "HTTP"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicFrontend"
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.bepool.id]
  probe_id                       = azurerm_lb_probe.http_probe.id
}
