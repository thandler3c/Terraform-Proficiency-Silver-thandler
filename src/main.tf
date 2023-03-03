locals {

  tm_profile_name = "tf-td-badge-001"
  application_abbr = "tftest"
  tags = { "Purpose" = "TF Training" }
}



# Configure Resource Gruop
module "rg" {
  source = "./modules/resource-group"

  resource_group = {
    create      = true
    name        = "rg-${local.application_abbr}-${var.location}"
    location    = var.location
    tags        = local.tags
  }
}

module "app_plan" {
  source = "./modules/service-plan-windows"

  windows_service_plan = {
    create    = true
    name      = "asp-${local.application_abbr}-${var.location}-001"
    location  = var.location
    rsg_name  = module.rg.name
    sku_name  = var.app_plan_sku
    tags      = local.tags
  }

}

module "app_service" {
  source = "./modules/web-app-windows"

  windows_web_app = {
    create          = true
    name            = var.web_app_name
    location        = var.location
    rsg_name        = module.rg.name
    tags            = local.tags
    service_plan_id = module.app_plan.id
  }

  depends_on = [
    module.app_plan
  ]

}


module "app_plan_secondary" {
  source = "./modules/service-plan-windows"

  windows_service_plan = {
    create    = true
    name      = "asp-${local.application_abbr}-${var.location}-002"
    location  = var.second_location
    rsg_name  = module.rg.name
    sku_name  = var.app_plan_sku
    tags      = local.tags
  }

}

module "app_service_secondary" {
  source = "./modules/web-app-windows"

  windows_web_app = {
    create          = true
    name            = var.web_app_name_2
    location        = var.second_location
    rsg_name        = module.rg.name
    tags            = local.tags
    service_plan_id = module.app_plan_secondary.id
  }

  depends_on = [
    module.app_plan_secondary
  ]

}

# Configure Traffic Manager Profile
module "tm_profile" {
  source = "./modules/tm-profile"

  tm_profile = {
    create   = true
    name     = local.tm_profile_name
    rsg_name = module.rg.name
    tags     = local.tags
  }
}

# Configure Azure endpoints
module "tm_endpoint" {
  source = "./modules/tm-azure-endpoint"

  tm_endpoint = {
    create        = true
    name          = "ep-app-service-001"
    tm_profile_id = module.tm_profile.id
    weight        = 1
    target        = module.app_service.id
    tags          = local.tags
  }
}

# Configure Azure endpoints
module "tm_endpoint_secondary" {
  source = "./modules/tm-azure-endpoint"

  tm_endpoint = {
    create        = true
    name          = "ep-app-service-002"
    tm_profile_id = module.tm_profile.id
    weight        = 2
    target        = module.app_service_secondary.id
    tags          = local.tags
  }
}