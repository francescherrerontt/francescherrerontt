virtual_machines_l = {
  "frontend01" = {
    extra_disks = [
      {
        size    = 13
        name    = "disk1"
        sa_type = "Standard_LRS"
      },
      {
        size    = 15
        name    = "disk22"
        sa_type = "Standard_LRS"
      }
    ]
    nb_public_ip     = "0"
    avset_name       = "front" ## use "" if you are not using an avset
    vm_size          = "Standard_D2s_v3"
    vnet_subnet_name = "snet-front"
    # set to null to asssign an IP automatically
    private_ip_address         = null
    encryption_at_host_enabled = false
  }
}
