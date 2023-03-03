variable location {
  type        = string
  description = "The Azure region to deploy resources"
}

variable second_location {
  type        = string
  description = "The Secondary Azure region to deploy resources"
}


variable environment {
  type        = string
  description = "Name of the environment"
}

variable app_plan_sku {
  type        = string
  description = "App service sku name"
}

variable web_app_name {
  type        = string
  description = "Name of the web app"
  default     = "app-bronze-tf-001"
}

variable web_app_name_2 {
  type        = string
  description = "Name of the web app"
  default     = "app-silver-tf-002"
}