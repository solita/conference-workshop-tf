terraform {
  backend "local" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.32.0"
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "core"
  resource_providers_to_register = [
    "Microsoft.ApiManagement",
  ]
  subscription_id = var.subscription_id
}
