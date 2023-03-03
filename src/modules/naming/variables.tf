variable "resource_type" {
  description = "(Required) Resource type name. The AzureRM resource type name. i.e. azurerm_analysis_services_server.  is validated against the resource_type_definition"
  type        = string
}

variable "environment_abbr" {
  description = "(required) environment abbreviation. used to specify which environment to deploy to. must be 3 characters."
  type        = string
  validation {
    condition = contains([
      "snd",
      "dev",
      "drc",
      "drl",
      "dmt",
      "dma",
      "qat",
      "qrc",
      "qrl",
      "qmt",
      "qma",
      "uat",
      "npd",
      "prd"
    ], var.environment_abbr)
    error_message = "the variable contains an invalid environment abbreviation."
  }
  validation {
    condition     = length(var.environment_abbr) == 3
    error_message = "the environment abbreviation variable must be 3 characters"
  }
}

variable "location_abbr" {
  description = "(required) location abbreviation. used to specify which azure region to deploy to. must be 4 characters."
  type        = string
  validation {
    condition = contains([
      "scus", #south central us
      "ncus", #north central us
      "eus", #east us
      "wus", #west us
    ], var.location_abbr)
    error_message = "the variable contains an invalid location abbreviation."
  }
  validation {
    condition     = length(var.location_abbr) >= 3 && length(var.location_abbr) <= 4
    error_message = "the location abbreviation variable must be between 3 and 5 characters."
  }
}

variable "application_abbr" {
  description = "(required) the platform, project, application, or architecture name tied to the resource."
  type        = string
  validation {
    condition = contains([
      "azm",
      "nth",
      "net",
      "abs",
      "acr",
      "jmp",
      "aks",
      "apim",
      "shr",
      "tftest"
    ], var.application_abbr)
    error_message = "the variable contains an invalid application abbreviation."
  }
}

variable "sequence_number" {
  description = "Instance sequence number for multiple deployments (e.g., 001, 002, etc.). max length (3)"
  type        = string
  default     = ""
  validation {
    condition     = length(var.sequence_number) < 4
    error_message = "The sequence_number variable must be 3 characters or less."
  }
}
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = ""
}

variable "global_padding" {
  description = "(Optional) - In situations where the name generated is not globally unique use this variable to add X number of characters from the subscription ID to the end of the name."
  type        = number
  default     = 0

  validation {
    condition     = var.global_padding < 7
    error_message = "The global_padding variable should be 6 characters or less."
  }
}

variable "resource_type_definition" {
  description = "(Internal) Resource type map used to provide information about each azure resource type or validation and naming"
  type        = map(object({ name = string, min_length = number, max_length = number, validation_regex = string, scope = string, abbr = string, dashes = bool, lowercase = bool, regex = string }))
  default = {
    azure_firewall = {
      name             = "azure_firewall"
      min_length       = 1
      max_length       = 56
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "afw"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_lb_internal = {
      name             = "azurerm_lb_internal"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "lbi"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_log_analytics_workspace = {
      name             = "azurerm_log_analytics_workspace"
      min_length       = 4
      max_length       = 63
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "log"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_kubernetes_cluster = {
      name             = "azurerm_kubernetes_cluster"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "clu"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_automation_account = {
      name             = "azurerm_automation_account"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "aa"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_firewall = {
      name             = "azurerm_firewall"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "afw"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_firewall_policy = {
      name             = "azurerm_firewall_policy"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "afwp"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_application_gateway = {
      name             = "azurerm_application_gateway"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "agw"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_bastion_host = {
      name             = "azurerm_bastion_host"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "parent"
      abbr             = "bas"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_express_route_circuit = {
      name             = "azurerm_express_route_circuit"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "erc"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_frontdoor = {
      name             = "azurerm_frontdoor"
      min_length       = 5
      max_length       = 64
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-]{3,62}[a-zA-Z0-9]$"
      scope            = "global"
      abbr             = "fd"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z-]"
    },
    azurerm_frontdoor_firewall_policy = {
      name             = "azurerm_frontdoor_firewall_policy"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "global"
      abbr             = "fdfw"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_linux_virtual_machine = {
      name             = "azurerm_linux_virtual_machine"
      min_length       = 1
      max_length       = 64
      validation_regex = "^[a-zA-Z0-9]{1}[a-zA-Z0-9-]*$"
      scope            = "resourceGroup"
      abbr             = "lnx"
      dashes           = true
      lowercase        = false
      regex            = "[\\\\/\\\"\\\\[\\\\]=|<>+=;?.*@&_]"
    },
    azurerm_public_ip = {
      name             = "azurerm_public_ip"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "parent"
      abbr             = "pip"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_public_ip_prefix = {
      name             = "azurerm_public_ip_prefix"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "parent"
      abbr             = "ippre"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_nat_gateway = {
      name             = "azurerm_nat_gateway"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "parent"
      abbr             = "ng"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_recovery_services_vault = {
      name             = "azurerm_recovery_services_vault"
      min_length       = 2
      max_length       = 50
      validation_regex = "^[a-zA-Z][a-zA-Z0-9-]{1,49}$"
      scope            = "resourceGroup"
      abbr             = "rsv"
      dashes           = true
      lowercase        = false
      regex            = "`[^a-zA-Z0-9-]`"
    },
    azurerm_recovery_services_vault_backup_police = {
      name             = "azurerm_recovery_services_vault_backup_police"
      min_length       = 3
      max_length       = 150
      validation_regex = "^[a-zA-Z][a-zA-Z0-9\\\\-]{11,48}[a-zA-Z0-9]$"
      scope            = "resourceGroup"
      abbr             = "rsvbp"
      dashes           = true
      lowercase        = false
      regex            = "`[^a-zA-Z0-9-]`"
    },
    azurerm_resource_group = {
      name             = "azurerm_resource_group"
      min_length       = 1
      max_length       = 90
      validation_regex = "^[a-zA-Z0-9-._\\\\(\\\\)]{0,89}[a-zA-Z0-9-_\\\\(\\\\)]$"
      scope            = "subscription"
      abbr             = "rg"
      dashes           = true
      lowercase        = false
      regex            = "`[^a-zA-Z0-9-._\\\\(\\\\)]`"
    },
    azurerm_key_vault = {
      name             = "azurerm_key_vault"
      min_length       = 3
      max_length       = 24
      validation_regex = "^[a-z0-9]{3,24}$"
      scope            = "subscription"
      abbr             = "kv"
      dashes           = false
      lowercase        = true
      regex            = "[^0-9a-z]"
    },
    azurerm_container_registry = {
      name             = "azurerm_container_registry"
      min_length       = 3
      max_length       = 24
      validation_regex = "^[a-z0-9]{3,24}$"
      scope            = "subscription"
      abbr             = "cr"
      dashes           = false
      lowercase        = true
      regex            = "[^0-9a-z]"
    },
    azurerm_storage_account = {
      name             = "azurerm_storage_account"
      min_length       = 3
      max_length       = 24
      validation_regex = "^[a-z0-9]{3,24}$"
      scope            = "global"
      abbr             = "st"
      dashes           = false
      lowercase        = true
      regex            = "[^0-9a-z]"
    },
    azurerm_storage_blob = {
      name             = "azurerm_storage_blob"
      min_length       = 1
      max_length       = 1024
      validation_regex = "^[^\\\\s\\\\/$#&]{1,1000}[^\\\\s\\\\/$#&]{0,24}$"
      scope            = "parent"
      abbr             = "blob"
      dashes           = true
      lowercase        = false
      regex            = "[\\\\s\\\\/$#&]"
    },
    azurerm_storage_container = {
      name                  = "azurerm_storage_container"
      min_length            = 3
      max_length            = 63
      validation_regex      = "^[a-z0-9][a-z0-9-]{2,62}$"
      "invalid-double-dash" = true
      scope                 = "parent"
      abbr                  = "stct"
      dashes                = true
      lowercase             = false
      regex                 = "[^0-9a-z-]"
    },
    azurerm_subnet = {
      name             = "azurerm_subnet"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "parent"
      abbr             = "snet"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_virtual_hub = {
      name             = "azurerm_virtual_hub"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "parent"
      abbr             = "vhub"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_virtual_network = {
      name             = "azurerm_virtual_network"
      min_length       = 2
      max_length       = 64
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,62}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "vnet"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_virtual_network_gateway = {
      name             = "azurerm_virtual_network_gateway"
      min_length       = 2
      max_length       = 64
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,62}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "vgw"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_local_network_gateway = {
      name             = "azurerm_local_network_gateway"
      min_length       = 2
      max_length       = 64
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,62}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "lgw"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_virtual_wan = {
      name             = "azurerm_virtual_wan"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "parent"
      abbr             = "vwan"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_windows_virtual_machine = {
      name             = "azurerm_windows_virtual_machine"
      min_length       = 1
      max_length       = 15
      validation_regex = "^[^\\\\/\\\"\\\\[\\\\]=|<>+=;.?.*@&_][^\\\\/\\\"\\\\[\\\\]=|<>+=;?*@&]{0,13}[^\\\\/\\\"\\\\[\\\\]=|<>+=;.?.*@&.-]$"
      scope            = "resourceGroup"
      abbr             = "win"
      dashes           = true
      lowercase        = false
      regex            = "[\\\\/\\\"\\\\[\\\\]=|<>+=;.?.*@&_]"
    },
    azurerm_application_insights = {
      name             = "azurerm_application_insights"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "ai"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_api_management = {
      name             = "azurerm_api_management",
      min_length       = 1
      max_length       = 50
      validation_regex = "^[a-zA-Z][a-zA-Z0-9-]{0,48}[a-zA-Z0-9]?$" # 1-50 characters, alphanumerics and hyphens, start with a letter and end with a letter or number
      scope            = "global"
      abbr             = "apim"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9a-zA-Z-]"
    },
    azurerm_api_management_logger = {
      name             = "azurerm_api_management_logger"
      min_length       = 1
      max_length       = 80
      validation_regex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_]$"
      scope            = "resourceGroup"
      abbr             = "apil"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z_.-]"
    },
    azurerm_synapse_workspace = {
      name             = "azurerm_synapse_workspace"
      min_length       = 1
      max_length       = 50
      validation_regex = "^[a-zA-Z][a-zA-Z0-9-]{0,48}[a-zA-Z0-9]$" # 1-50 characters, alphanumerics and hyphens, start with a letter and end with a letter or number
      scope            = "global"
      abbr             = "syn"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z-]"
    },
    azurerm_synapse_sql_pool = {
      name             = "azurerm_synapse_sql_pool"
      min_length       = 1
      max_length       = 60
      validation_regex = "^[a-zA-Z][a-zA-Z0-9_]{0,58}[a-zA-Z0-9]$" # 1-60 characters, alphanumerics and underscore, start with a letter and end with a letter or number
      scope            = "workspace"
      abbr             = "synsql"
      dashes           = false
      lowercase        = false
      regex            = "[^0-9A-Za-z_]"
    },
    azurerm_synapse_spark_pool = {
      name             = "azurerm_synapse_spark_pool"
      min_length       = 1
      max_length       = 15
      validation_regex = "^[a-zA-Z][a-zA-Z0-9]{0,14}$" # 1-15 characters, alphanumerics, start with a letter and end with a letter or number
      scope            = "workspace"
      abbr             = "synspk"
      dashes           = false
      lowercase        = false
      regex            = "[^0-9A-Za-z]"
    },
    azurerm_synapse_private_link_hub = {
      name             = "azurerm_synapse_private_link_hub"
      min_length       = 1
      max_length       = 45
      validation_regex = "^[a-zA-Z][a-zA-Z0-9]{0,44}$" # 1-60 characters, alphanumerics, start with a letter and end with a letter or number
      scope            = "global"
      abbr             = "synpl"
      dashes           = false
      lowercase        = false
      regex            = "[^0-9A-Za-z]"
    },
    azurerm_data_factory = {
      name             = "azurerm_data_factory"
      min_length       = 3
      max_length       = 63
      validation_regex = "^[a-zA-Z][a-zA-Z0-9-]{0,61}[a-zA-Z0-9]$" # 1-63 characters, alphanumerics and hyphen, start with a letter and end with a letter or number
      scope            = "global"
      abbr             = "adf"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z-]"
    },
    azurerm_mssql_server = {
      name             = "azurerm_mssql_server"
      min_length       = 1
      max_length       = 63
      validation_regex = "^[a-zA-Z][a-zA-Z0-9-]{0,61}[a-zA-Z0-9]$" # 1-63 characters, alphanumerics and hyphen, start with a letter and end with a letter or number
      scope            = "global"
      abbr             = "sql"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z-]"
    },
    azurerm_mssql_database = {
      name             = "azurerm_mssql_database"
      min_length       = 1
      max_length       = 128
      validation_regex = "^[a-zA-Z][a-zA-Z0-9-_]{0,126}[a-zA-Z0-9]$" # 1-128 characters, alphanumerics, underscore, and hyphen, start with a letter and end with a letter or number
      scope            = "server"
      abbr             = "db"
      dashes           = true
      lowercase        = false
      regex            = "[^0-9A-Za-z-_]"
    }
  }
}
