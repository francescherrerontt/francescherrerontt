/*
Default standard NSG rules covering some management servers.
To be used when PSZ is available.
Additional will be required as per project design.
Replace the following keys before using:
 <PLATFORM_CIDR>     = Address space/s composing the full customer platform (all vNETs)
 <VNET_CIDR>         = Address space/s of the current vnet
 <AUTOMATION_SERVER> = IP of the automation server (docker host) - Only required if using PSZ
 <STAGING_SERVER>    = IP of the staging server - Only required if using PSZ
 <LM_COLLECTOR>      = IP of logic monitor collector - Only required if using PSZ
*/

/* Uncomment this if your solution contains a PSZ
nsg = {
  "nsg-prod-icmp-allow" = {
      nsg_name = "prod"
      action   = "Allow"
      priority = 201
      protocol = "Icmp"
      source_port_ranges = ["*"]
      destination_port_ranges = ["*"]
      source_address_prefixes = ["<PLATFORM_CIDR>"]
      destination_address_prefixes = ["<VNET_CIDR>"]
      description = "Allow icmp from trusted networks"
    }
  "nsg-prod-staging-allow" = {
      nsg_name = "prod"
      action   = "Allow"
      priority = 202
      protocol = "*"
      source_port_ranges = ["*"]
      destination_port_ranges = ["*"]
      source_address_prefixes = ["<STAGING_SERVER>"]
      destination_address_prefixes = ["<VNET_CIDR>"]
      description = "Allow access from staging server"
    }
  "nsg-prod-ansible-allow" = {
      nsg_name = "prod"
      action   = "Allow"
      priority = 203
      protocol = "TCP"
      source_port_ranges = ["*"]
      destination_port_ranges = ["22","443","5986"]
      source_address_prefixes = ["<AUTOMATION_SERVER>"]
      destination_address_prefixes = ["<VNET_CIDR>"]
      description = "Allow access from Ansible server"
    }
  "nsg-prod-logicmonitor-allow" = {
      nsg_name = "prod"
      action   = "Allow"
      priority = 204
      protocol = "*"
      source_port_ranges = ["*"]
      destination_port_ranges = ["*"]
      source_address_prefixes = ["<LM_COLLECTOR>"]
      destination_address_prefixes = ["<VNET_CIDR>"]
      description = "Allow access from Logic Monitor collectors"
    }
  "nsg-db-icmp-allow" = {
      nsg_name = "db"
      action   = "Allow"
      priority = 201
      protocol = "Icmp"
      source_port_ranges = ["*"]
      destination_port_ranges = ["*"]
      source_address_prefixes = ["<PLATFORM_CIDR>"]
      destination_address_prefixes = ["<VNET_CIDR>"]
      description = "Allow icmp from trusted networks"
    }
  "nsg-db-staging-allow" = {
      nsg_name = "db"
      action   = "Allow"
      priority = 202
      protocol = "*"
      source_port_ranges = ["*"]
      destination_port_ranges = ["*"]
      source_address_prefixes = ["<STAGING_SERVER>"]
      destination_address_prefixes = ["<VNET_CIDR>"]
      description = "Allow access from staging server"
    }
  "nsg-db-ansible-allow" = {
      nsg_name = "db"
      action   = "Allow"
      priority = 203
      protocol = "TCP"
      source_port_ranges = ["*"]
      destination_port_ranges = ["22","443","5986"]
      source_address_prefixes = ["<AUTOMATION_SERVER>"]
      destination_address_prefixes = ["<VNET_CIDR>"]
      description = "Allow access from Ansible server"
    }
  "nsg-db-logicmonitor-allow" = {
      nsg_name = "db"
      action   = "Allow"
      priority = 204
      protocol = "*"
      source_port_ranges = ["*"]
      destination_port_ranges = ["*"]
      source_address_prefixes = ["<LM_COLLECTOR>"]
      destination_address_prefixes = ["<VNET_CIDR>"]
      description = "Allow access from Logic Monitor collectors"
    }
}
*/

/* Uncomment this if your solution does NOT contain a PSZ
nsg = {
  "nsg-prod-icmp-allow" = {
      nsg_name = "prod"
      action   = "Allow"
      priority = 201
      protocol = "Icmp"
      source_port_ranges = ["*"]
      destination_port_ranges = ["*"]
      source_address_prefixes = ["<PLATFORM_CIDR>"]
      destination_address_prefixes = ["<VNET_CIDR>"]
      description = "Allow icmp from trusted networks"
    }
  "nsg-prod-mgmt-allow" = {
      nsg_name = "prod"
      action   = "Allow"
      priority = 202
      protocol = "*"
      source_port_ranges = ["*"]
      destination_port_ranges = ["*"]
      source_address_prefixes = ["10.157.80.0/22","10.157.96.0/22","10.157.104.0/22"]
      destination_address_prefixes = ["<VNET_CIDR>"]
      description = "Allow access from smz"
    }
  "nsg-db-icmp-allow" = {
      nsg_name = "prod"
      action   = "Allow"
      priority = 201
      protocol = "Icmp"
      source_port_ranges = ["*"]
      destination_port_ranges = ["*"]
      source_address_prefixes = ["<PLATFORM_CIDR>"]
      destination_address_prefixes = ["<VNET_CIDR>"]
      description = "Allow icmp from trusted networks"
    }
  "nsg-db-mgmt-allow" = {
      nsg_name = "prod"
      action   = "Allow"
      priority = 202
      protocol = "*"
      source_port_ranges = ["*"]
      destination_port_ranges = ["*"]
      source_address_prefixes = ["10.157.80.0/22","10.157.96.0/22","10.157.104.0/22"]
      destination_address_prefixes = ["<VNET_CIDR>"]
      description = "Allow access from smz"
    }
}
*/

nsg_assoc = {
  "prod" = {
    subnet_id = 0
  },
  "db" = {
    subnet_id = 1
  }
}
