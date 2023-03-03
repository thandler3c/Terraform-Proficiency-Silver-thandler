resource "azurerm_service_plan" "service_plan" {
    # create              = var.windows_service_plan.create ? 1 : 0
    name                = var.windows_service_plan.name
    resource_group_name = var.windows_service_plan.rsg_name
    location            = var.windows_service_plan.location
    sku_name            = var.windows_service_plan.sku_name
    os_type             = "Windows"
}