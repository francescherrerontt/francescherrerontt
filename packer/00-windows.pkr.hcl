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
  default = "windows2019_base"
}

variable "gallery_name" {
  type    = string
  default = "packer_image_gallery"
}

variable "image_sku" {
  type    = string
  default = "2019-Datacenter-gensecond"
}

# "timestamp" template function replacement
locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
  image_version = formatdate("YYYYMMDD.hh.mm", timestamp())
}

source "azure-arm" "windows_base" {
  azure_tags = {
  "ntt_auto_cloud_iac" = "GEN000XXXXXX"
  }
  communicator                      = "winrm"
  image_offer                       = "WindowsServer"
  image_publisher                   = "MicrosoftWindowsServer"
  image_sku                         = var.image_sku
  managed_image_name                = "${var.vm_group}-${local.image_version}"
  managed_image_resource_group_name = var.az_resource_group
  build_resource_group_name         = var.az_resource_group
  os_type                           = "Windows"
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
  winrm_insecure  = true
  winrm_timeout   = "5m"
  winrm_use_ssl   = true
  winrm_username  = "nttrmadm"
}

build {
  sources = ["source.azure-arm.windows_base"]

  provisioner "powershell" {
    inline = [
      "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12",
      "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1' -UseBasicParsing -Outfile C:\\windows\\TEMP\\ConfigureRemotingForAnsible.ps1",
      "powershell.exe -ExecutionPolicy Bypass -File 'c:\\windows\\temp\\ConfigureRemotingForAnsible.ps1' -CertValidityDays 3650 -Verbose"
    ]
  }

  provisioner "ansible" {
    extra_arguments = [
      "--extra-vars",
      "ansible_winrm_server_cert_validation=ignore",
      "--skip-tags",
      "windows_ntt_2.1.1,windows_ntt_1.8.4,windows_ntt_1.8.3,windows_ntt_1.8.2,windows_cis_1.2.3,windows_cis_2.3.1.1,risk_level-4,windows_ntt_1.2.4"
    ]
    playbook_file = "/srv/ansible-data/playbooks/compliance/compliance.yml"
    groups = [
      "windows"
    ]
    user = "nttrmadm"
    use_proxy = false
    roles_path = "/srv/ansible-data/roles"
  }

  provisioner "ansible" {
    playbook_file = "scripts/windows_updates.yml"
  }
  provisioner "powershell" {
    inline = [
      "Set-Service RdAgent -StartupType Disabled",
      "Set-Service WindowsAzureGuestAgent -StartupType Disabled",
      "Remove-ItemProperty -Path 'HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\SysPrepExternal\\Generalize' -Name '*'"
    ]
  }

  provisioner "windows-restart" {
    restart_check_command = "powershell -command \"& {Write-Output 'restarted.'}\""
  }

  provisioner "powershell" {
    script = "./scripts/sysprep.ps1"
  }
}
