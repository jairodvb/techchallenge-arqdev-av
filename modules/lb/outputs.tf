output "backend_address_pool_id" {
  value = azurerm_lb_backend_address_pool.bepool.id
}

output "public_ip_id" {
  value = azurerm_public_ip.lb_pip.id
}
