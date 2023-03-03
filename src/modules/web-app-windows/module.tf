resource "azurerm_windows_web_app" "web_app" {
  name                = var.windows_web_app.name
  resource_group_name = var.windows_web_app.rsg_name
  location            = var.windows_web_app.location
  service_plan_id     = var.windows_web_app.service_plan_id

  site_config {}
}