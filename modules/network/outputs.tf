output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vmss_subnet_id" {
  value = azurerm_subnet.vmss.id
}

output "appgw_subnet_id" {
  value = azurerm_subnet.appgw.id
}
