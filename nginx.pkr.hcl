packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = ">= 2.1.9"
    }
    ansible = {
      version = ">= 1.1.2"
      source = "github.com/hashicorp/ansible"
    }
  }
}
variable "subscription_id" {
  type    = string
}
variable "client_secret" {
  type    = string
}
variable "tenant_id" {
  type    = string
}
variable "client_id" {
  type    = string
}

source "azure-arm" "debian-nginx" {
  client_id                         = var.client_id
  client_secret                     = var.client_secret
  subscription_id                   = var.subscription_id
  tenant_id                         = var.tenant_id

  os_type                           = "Linux"
  vm_size                           = "Standard_D2as_v4"
  location                          = "Canada Central"

  image_offer                       = "debian-12"
  image_publisher                   = "debian"
  image_sku                         = "12"

  shared_image_gallery_destination  {
    resource_group = "VM_Builder"
    gallery_name = "Gallery"
    image_name = "nginx"
    image_version = "1.0.0"
  }
}

build {
  sources = ["source.azure-arm.debian-nginx"]

  provisioner "ansible" {
    playbook_file = "./nginx.yaml"
  }
}
