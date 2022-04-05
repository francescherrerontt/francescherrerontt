/*
Default standard NSG rules covering some management servers.
Additional will be required as per project design.
Replace the following keys before using:
 <PLATFORM_CIDR>     = Address space/s composing the full customer platform (all vNETs)
 <VNET_CIDR>         = Address space/s of the current vnet
 <AUTOMATION_SERVER> = IP of the automation server (docker host)
 <SALT_MASTER>       = IP of salt master
 <LM_COLLECTOR>      =	IP of logic monitor collector
*/
/* Uncomment after filling in missing information
nsg = {
  "nsg-icmp-allow" = {
    nsg_name                     = "nsg-psz"
    action                       = "Allow"
    priority                     = 201
    protocol                     = "Icmp"
    source_port_ranges           = ["*"]
    destination_port_ranges      = ["*"]
    source_address_prefixes      = ["10.157.80.0/22", "10.157.96.0/22", "10.157.104.0/22", "<PLATFORM_CIDR>"]
    destination_address_prefixes = ["<VNET_CIDR>"]
    description                  = "Allow icmp from trusted networks"
  }
  "nsg-mgmt-allow" = {
    nsg_name                     = "nsg-psz"
    action                       = "Allow"
    priority                     = 202
    protocol                     = "*"
    source_port_ranges           = ["*"]
    destination_port_ranges      = ["*"]
    source_address_prefixes      = ["10.157.80.0/22", "10.157.96.0/22", "10.157.104.0/22"]
    destination_address_prefixes = ["<VNET_CIDR>"]
    description                  = "Allow management from amz/smz"
  }
  "nsg-salt-allow" = {
    nsg_name                     = "nsg-psz"
    action                       = "Allow"
    priority                     = 203
    protocol                     = "TCP"
    source_port_ranges           = ["*"]
    destination_port_ranges      = ["4505", "4506"]
    source_address_prefixes      = ["<PLATFORM_CIDR>"]
    destination_address_prefixes = ["<SALT_MASTER>"]
    description                  = "Allow access to Salt master"
  }
  "nsg-ansible-allow" = {
    nsg_name                     = "nsg-psz"
    action                       = "Allow"
    priority                     = 204
    protocol                     = "TCP"
    source_port_ranges           = ["*"]
    destination_port_ranges      = ["22", "443", "5986"]
    source_address_prefixes      = ["<AUTOMATION_SERVER>"]
    destination_address_prefixes = ["<VNET_CIDR>"]
    description                  = "Allow access from Ansible server"
  }
  "nsg-logicmonitor-allow" = {
    nsg_name                     = "nsg-psz"
    action                       = "Allow"
    priority                     = 205
    protocol                     = "*"
    source_port_ranges           = ["*"]
    destination_port_ranges      = ["*"]
    source_address_prefixes      = ["<LM_COLLECTOR>"]
    destination_address_prefixes = ["<VNET_CIDR>"]
    description                  = "Allow access from Logic Monitor collectors"
  }
}
*/

nsg_assoc = {
  "nsg-psz" = {
    subnet_id = 1
  }
}
