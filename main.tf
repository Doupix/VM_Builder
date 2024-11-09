terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.8.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

variable "subscription_id" {
  type = string
}
variable "resource_group" {
  type = string
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = false
    }
  }
}

resource "azurerm_resource_group" "vmbuilder" {
  name     = var.resource_group
  location = "Canada Central"
}
