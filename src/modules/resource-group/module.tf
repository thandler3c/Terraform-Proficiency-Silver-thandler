resource "azurerm_resource_group" "rg" {
    count       = var.resource_group.create ? 1 : 0
    name        = var.resource_group.name
    location    = var.resource_group.location
    #tags        = var.resource_group.tags
}