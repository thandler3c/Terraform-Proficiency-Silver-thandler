provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.43.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "stahandleriac001"
    resource_group_name  = "rg-thandler"
    container_name       = "tfstates"
    subscription_id      = "d5736eb1-f851-4ec3-a2c5-ac8d84d029e2"
  }
}