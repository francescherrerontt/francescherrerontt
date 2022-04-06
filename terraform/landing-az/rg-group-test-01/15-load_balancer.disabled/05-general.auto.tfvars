# Load balancers definition
load_balancers = {
  "loadbalancer01" = {
    pip_name                               = ""
    lb_probe_unhealthy_threshold           = 2
    lb_probe_interval                      = 5
    allocation_method                      = "Static"
    type                                   = "public"
    frontend_subnet_name                   = ""
    frontend_private_ip_address            = ""
    frontend_private_ip_address_allocation = "Dynamic"
    pip_domain_name_label                  = "projectskel-dns-group-test-01"
    pip_availability_zone                  = "1"
    enable_floating_ip                     = false
    remote_port = {
      ssh = ["Tcp", "22"]
    }
    lb_port = {
      http = ["80", "Tcp", "80"]
    }
    lb_probe = {
      http = ["Http", "80", "/svcheck.php"]
    }
  }
  "loadbalancer02" = {
    pip_name                               = ""
    lb_probe_unhealthy_threshold           = 2
    lb_probe_interval                      = 5
    allocation_method                      = "Static"
    type                                   = "private"
    frontend_subnet_name                   = "snet-back"
    frontend_private_ip_address            = ""
    frontend_private_ip_address_allocation = "Dynamic"
    pip_domain_name_label                  = ""
    pip_availability_zone                  = ""
    enable_floating_ip                     = false
    remote_port = {
      ssh = ["Tcp", "3389"]
    }
    lb_port = {
      http = ["80", "Tcp", "80"]
    }
    lb_probe = {
      http = ["Tcp", "80", ""]
    }
  }
}

# Option 1: Add IP addresses to a load balancer
lb_ips_asoc = {
  "ipasoc01" = {
    lb = "loadbalancer01"
    ip = "10.0.0.1"
  }
  "ipasoc02" = {
    lb = "loadbalancer01"
    ip = "10.0.0.2"
  }
  "ipasoc03" = {
    lb = "loadbalancer01"
    ip = "10.0.0.3"
  }
}

## Option 2: add network interfaces to a load balancer
#lb_nics_asoc = {
#  "vmdevback01-ip-0" = {
#    lb = "loadbalancer02"
#    id = "/subscriptions/f9818f98-857b-4358-abf0-b4cd3a207682/resourceGroups/rg-dev-cwzjja/providers/Microsoft.Network/networkInterfaces/vmdevback01-nic-0"
#  }
#}
