
resource "azurerm_traffic_manager_azure_endpoint" "endpoint" {
  count              = var.tm_endpoint.create ? 1 : 0
  name               = var.tm_endpoint.name
  profile_id         = var.tm_endpoint.tm_profile_id
  weight             = var.tm_endpoint.weight
  target_resource_id = var.tm_endpoint.target

}
