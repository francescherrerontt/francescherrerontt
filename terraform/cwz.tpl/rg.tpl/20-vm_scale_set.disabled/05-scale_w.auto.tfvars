vm_scale_set_w = {
  "front" = {
    subnet_name                        = "snet-front"
    vm_computer_name                   = "front"
    os_flavor                          = "windows"
    instances_count                    = 2
    virtual_machine_size               = "Standard_A2_v2"
    load_balancer_type                 = "public"
    load_balancer_health_probe_port    = 80
    load_balanced_port_list            = [80, 443]
    additional_data_disks              = [100]
    minimum_instances_count            = 2
    maximum_instances_count            = 5
    scale_out_cpu_percentage_threshold = 80
    scale_in_cpu_percentage_threshold  = 0
    nsg_inbound_rules = [
      {
        name                   = "http"
        destination_port_range = "80"
        source_address_prefix  = "*"
      },

      {
        name                   = "https"
        destination_port_range = "443"
        source_address_prefix  = "*"
      },
    ]
  }
}
