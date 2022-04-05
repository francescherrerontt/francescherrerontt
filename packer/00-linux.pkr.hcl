variable "az_subscription_id" {
  type    = string
  default = null
}

variable "az_tenant_id" {
  type    = string
  default = null
}

variable "az_client_id" {
  type    = string
  default = null
}

variable "az_client_secret" {
  type    = string
  default = null
}

variable "location" {
  type    = string
  default = null
}

variable "az_resource_group" {
  type    = string
  default = "globalrg"
}

variable "vm-size" {
  type    = string
  default = "Standard_DS1_v2"
}

variable "vm_group" {
  type    = string
  default = "linux_base"
}

variable "gallery_name" {
  type    = string
  default = "packer_image_gallery"
}

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

variable "image_offer" {
  type    = string
  default = "UbuntuServer"
}

variable "image_sku" {
  type    = string
  default = "18.04-LTS"
}

# "timestamp" template function replacement
locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
  image_version = formatdate("YYYYMMDD.hh.mm", timestamp())
}

source "azure-arm" "linux_base" {
  azure_tags = {
  "ntt_auto_cloud_iac" = "GEN000XXXXXX"
  }
  image_offer                       = var.image_offer
  image_publisher                   = var.image_publisher
  image_sku                         = var.image_sku
  managed_image_name                = "${var.vm_group}-${local.image_version}"
  managed_image_resource_group_name = var.az_resource_group
  build_resource_group_name         = var.az_resource_group
  os_type                           = "Linux"
  shared_image_gallery_destination {
    gallery_name        = var.gallery_name
    image_name          = var.vm_group
    image_version       = local.image_version
    replication_regions = [var.location]
    resource_group      = var.az_resource_group
    subscription        = var.az_subscription_id
  }
  subscription_id = var.az_subscription_id
  tenant_id       = var.az_tenant_id
  client_id       = var.az_client_id
  client_secret   = var.az_client_secret
  vm_size         = var.vm-size
}

build {
  sources = ["source.azure-arm.linux_base"]

  provisioner "file" {
     source = "scripts/bootstrap.sh"
     destination = "/tmp/bootstrap.sh"
  }

  provisioner "shell" {
    execute_command = "echo 'packer'|{{.Vars}} sudo -S -E bash '{{.Path}}'"
    script = "./scripts/bootstrap.sh"
  }

  provisioner "ansible" {
    extra_arguments = [
      "--become",
      "--skip-tags",
      "apache,risk_level-4,linux_cis_5.2.14,linux_cis_1.1.1.7,linux_cis_1.1.1.8,linux_ntt_3.2.10,linux_ntt_3.2.8"
    ]
    playbook_file = "/srv/ansible-data/playbooks/compliance/compliance.yml"
    groups = [
      "linux"
    ]
    use_proxy = false
    roles_path = "/srv/ansible-data/roles"
  }

  provisioner "shell" {
    execute_command = "echo 'packer'|{{.Vars}} sudo -S -E bash '{{.Path}}'"
    scripts = ["./scripts/cleanup.sh"]
  }
  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline = ["/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
    inline_shebang = "/bin/sh -x"
  }
}
