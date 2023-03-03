output "id" {
  value = length(azurerm_resource_group.rg) > 0 ? azurerm_resource_group.rg[0].id : ""
}

output "name" {
  value = length(azurerm_resource_group.rg) > 0 ? azurerm_resource_group.rg[0].name : ""
}