virtual_machines_w = {
  "back01" = {
    vm_os_simple = "WindowsServer"
    nb_public_ip = "0"
    avset_name   = "back" ## use "" if you are not using an avset
    vm_size      = "Standard_D2s_v3"
    # set to null to asssign an IP automatically
    private_ip_address = null
    os_disk = {
      disk_size_gb         = "128",
      storage_account_type = "Standard_LRS"
    }
    vnet_subnet_name           = "snet-back"
    encryption_at_host_enabled = false
    extra_disks = [
      {
        size    = 25
        name    = "disk1"
        sa_type = "Standard_LRS"
      }
    ]
  }
}
