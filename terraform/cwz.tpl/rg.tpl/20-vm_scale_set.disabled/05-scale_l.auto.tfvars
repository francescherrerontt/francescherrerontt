vm_scale_set_l = {
  "back" = {
    subnet_name                        = "snet-back"
    vm_computer_name                   = "back"
    instances_count                    = 2
    virtual_machine_size               = "Standard_A2_v2"
    load_balancer_type                 = "private"
    load_balancer_health_probe_port    = 8080
    load_balanced_port_list            = [8080]
    additional_data_disks              = []
    minimum_instances_count            = 2
    maximum_instances_count            = 5
    scale_out_cpu_percentage_threshold = 80
    scale_in_cpu_percentage_threshold  = 20
    nsg_inbound_rules = [
      {
        name                   = "http"
        destination_port_range = "8080"
        source_address_prefix  = "*"
      },
    ]
  }
}
