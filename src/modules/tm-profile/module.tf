variable "tm_profile" {
  type = object({
    create   = bool
    name     = string
    rsg_name = string
    tags     = map(string)
  })

}

resource "azurerm_traffic_manager_profile" "tm" {

  count                  = var.tm_profile.create ? 1 : 0
  name                   = var.tm_profile.name
  resource_group_name    = var.tm_profile.rsg_name
  traffic_routing_method = "Priority"
  tags                   = var.tm_profile.tags

  dns_config {
    relative_name = var.tm_profile.name
    ttl           = 60
  }

  monitor_config {
    protocol                     = "HTTPS"
    port                         = 443
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 10
    tolerated_number_of_failures = 3
  }

  lifecycle {
    ignore_changes = [
      tags["CreatedBy"],
      tags["CreatedOn"]
    ]
  }
}

output "id" {
  value = azurerm_traffic_manager_profile.tm[0].id
}