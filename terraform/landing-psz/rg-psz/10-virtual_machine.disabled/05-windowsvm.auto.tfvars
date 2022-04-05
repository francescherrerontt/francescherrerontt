virtual_machines_w = {
  "jump01" = {
    vm_os_simple       = "WindowsServer"
    nb_public_ip       = "0"
    avset_name         = "jump" ## use "" if you are not using an avset
    vm_size            = "Standard_D2s_v3"
    private_ip_address = null
    os_disk = {
      disk_size_gb         = "128",
      storage_account_type = "Standard_LRS"
    }
    extra_disks                = []
    vnet_subnet_name           = "snet-psz"
    encryption_at_host_enabled = false
  },
  "lmc01" = {
    vm_os_simple       = "WindowsServer"
    nb_public_ip       = "0"
    private_ip_address = null
    avset_name         = "lmc"
    vm_size            = "Standard_D2s_v3"
    os_disk = {
      disk_size_gb         = "128",
      storage_account_type = "Standard_LRS"
    }
    extra_disks                = []
    vnet_subnet_name           = "snet-psz"
    encryption_at_host_enabled = false
  },
}
