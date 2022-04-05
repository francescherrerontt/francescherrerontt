virtual_machines_l = {
  "auto01" = {
    extra_disks = [
      {
        size    = 13
        name    = "disk1"
        sa_type = "Standard_LRS"
      }
    ]
    nb_public_ip               = "0"
    avset_name                 = "auto" ## use "" if you are not using an avset
    vm_size                    = "Standard_F4s_v2"
    vnet_subnet_name           = "snet-psz"
    private_ip_address         = null
    encryption_at_host_enabled = false
  }
}
