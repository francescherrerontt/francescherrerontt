address_space = "10.81.0.0/22"
dns_servers   = ["8.8.8.8"]
subnet_objects = [
  {
    name   = "GatewaySubnet"
    prefix = "10.81.0.0/26"
  },
  {
    name   = "snet-psz"
    prefix = "10.81.1.0/24"
  },
]

/* Example
delegations = {
  snet-gwc-dev-cmp-anf-01 = {
    del-gwc-dev-cmp-netapp-01 = {
      service_delegation_name = "Microsoft.Netapp/volumes"
      actions = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}
*/
delegations = {}

/* Example
subnet_enforce_private_link_endpoint_network_policies = {
  snet-gwc-dev-cmp-pep-01 = true
}
*/
subnet_enforce_private_link_endpoint_network_policies = {}

/* Example
subnet_service_endpoints = {
    "subnet1" : ["Microsoft.Sql"], 
    "subnet2" : ["Microsoft.Sql"],
    "subnet3" : ["Microsoft.Sql"]
  }
*/
subnet_service_endpoints = {}