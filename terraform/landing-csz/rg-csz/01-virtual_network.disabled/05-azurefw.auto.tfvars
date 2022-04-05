/*
Default standard network rules for Azure FW covering some management servers.
Additional will be required as per project design.
Replace the following keys before using:
 <PLATFORM_CIDR>     = Address space/s composing the full customer platform (all vNETs)
 <PSZ_CIDR>          = Address space/s used in the PSZ (if available)
 <AUTOMATION_SERVER> = IP of the automation server (docker host)
 <STAGING_SERVER>    = IP of the staging server
 <SALT_MASTER>       = IP of salt master
 <LM_COLLECTOR>      = IP of logic monitor collector
*/

/* Uncomment this if your solution contains a PSZ 
firewall_network_rules = {
  }
  nr-ntt-mgmt-allow = {
    priority         = 201
    action           = "Allow"
    rules = {
      r-staging = {
        description      = "Allow access from Staging Server"
        source_addresses = ["<STAGING_SERVER>"]
        destination_addresses = ["<PLATFORM_CIDR>"]
        destination_ports     = ["*"]
        protocols = ["Any"]
      }
      r-ansible = {
        description      = "Allow access from Ansible"
        source_addresses = ["<AUTOMATION_SERVER>"]
        destination_addresses = ["<PLATFORM_CIDR>"]
        destination_ports     = ["22","443","5986"]
        protocols = ["TCP"]
      }
      r-logicmonitor = {
        description      = "Allow access from Logic Monitor collector"
        source_addresses = ["<LM_COLLECTOR>"]
        destination_addresses = ["<PLATFORM_CIDR>"]
        destination_ports     = ["*"]
        protocols = ["Any"]
      }
      r-salt = {
        description      = "Allow access to Salt master"
        source_addresses = ["<PLATFORM_CIDR>"]
        destination_addresses = ["<SALT_MASTER>"]
        destination_ports     = ["4505","4506"]
        protocols = ["TCP"]
      }
      r-icmp-out = {
        description      = "Allow ping from psz to the internet"
        source_addresses = ["<PSZ_CIDR>"]
        destination_addresses = ["*"]
        destination_ports     = ["*"]
        protocols = ["ICMP"]
      }
      r-web-out = {
        description      = "Allow web from psz to the internet"
        source_addresses = ["<PSZ_CIDR>"]
        destination_addresses = ["*"]
        destination_ports     = ["80","443"]
        protocols = ["TCP"]
      }
      r-haproxy = {
        description      = "Allow access to SMZ HA proxy"
        source_addresses = ["<AUTOMATION_SERVER>"]
        destination_addresses = ["10.157.83.247"]
        destination_ports     = ["22"]
        protocols = ["TCP"]
      }
      r-logstash = {
        description      = "Allow access from SMZ Logstash"
        source_addresses = ["<AUTOMATION_SERVER>"]
        destination_addresses = ["10.157.81.8"]
        destination_ports     = ["8080"]
        protocols = ["TCP"]
      }
    }
  }
  nr-dns-out-allow = {
    priority         = 202
    action           = "Allow"
    rules = {
      r-dns = {
        description      = "Allow dns to the internet"
        source_addresses = ["<PLATFORM_CIDR>"]
        destination_addresses = ["*"]
        destination_ports     = ["53"]
        protocols = ["UDP"]
      }
    }
  }
}
*/

/* Uncomment this if your solution does NOT contain a PSZ 
firewall_network_rules = {
  nr-ntt-mgmt-allow = {
    priority         = 201
    action           = "Allow"
    rules = {
      r-staging = {
        description      = "Allow access from Staging Server"
        source_addresses = ["<STAGING_SERVER>"]
        destination_addresses = ["<PLATFORM_CIDR>"]
        destination_ports     = ["*"]
        protocols = ["Any"]
      }
      r-ansible = {
        description      = "Allow access from Ansible"
        source_addresses = ["<AUTOMATION_SERVER>"]
        destination_addresses = ["<PLATFORM_CIDR>"]
        destination_ports     = ["22","443","5986"]
        protocols = ["TCP"]
      }
      r-logicmonitor = {
        description      = "Allow access from Logic Monitor collector"
        source_addresses = ["<LM_COLLECTOR>"]
        destination_addresses = ["<PLATFORM_CIDR>"]
        destination_ports     = ["*"]
        protocols = ["Any"]
      }
      r-salt = {
        description      = "Allow access to Salt master"
        source_addresses = ["<PLATFORM_CIDR>"]
        destination_addresses = ["<SALT_MASTER>"]
        destination_ports     = ["4505","4506"]
        protocols = ["TCP"]
      }
      r-haproxy = {
        description      = "Allow access to SMZ HA proxy"
        source_addresses = ["<AUTOMATION_SERVER>"]
        destination_addresses = ["10.157.83.247"]
        destination_ports     = ["22"]
        protocols = ["TCP"]
      }
      r-logstash = {
        description      = "Allow access from SMZ Logstash"
        source_addresses = ["<AUTOMATION_SERVER>"]
        destination_addresses = ["10.157.81.8"]
        destination_ports     = ["8080"]
        protocols = ["TCP"]
      }
    }
  }
  nr-dns-out-allow = {
    priority         = 202
    action           = "Allow"
    rules = {
      r-dns = {
        description      = "Allow dns to the internet"
        source_addresses = ["<PLATFORM_CIDR>"]
        destination_addresses = ["*"]
        destination_ports     = ["53"]
        protocols = ["UDP"]
      }
    }
  }
}
*/

# Check module documentation for examples
# https://scm.capside.com/terraform/azure/terraform-azurerm-azurefw
firewall_application_rules = {}
firewall_nat_rules         = {}

custom_firewall_name = ""
