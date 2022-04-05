
route_tablesva = {
  "GatewaySubnet" = {
    routes = [
      {
        name              = "CommonServicesSubnet"
        prefix            = "10.80.1.0/24"
        nexthop_type      = "VirtualAppliance"
        route_nexthop_ips = "10.80.0.68"
      },
      {
        name              = "vnet-psz"
        prefix            = "10.81.0.0/22"
        nexthop_type      = "VirtualAppliance"
        route_nexthop_ips = "10.80.0.68"
      },
      {
        name              = "vnet-cwz-ecommerce01"
        prefix            = "10.82.0.0/22"
        nexthop_type      = "VirtualAppliance"
        route_nexthop_ips = "10.80.0.68"
      },
    ]
    disable_bgp_route_propagation = false
  },
  "AzureFirewallSubnet" = {
    routes = [
      {
        name              = "Internet"
        prefix            = "0.0.0.0/0"
        nexthop_type      = "Internet"
        route_nexthop_ips = null
      }
    ]
    disable_bgp_route_propagation = false
  },
  "internal" = {
    routes = [
      {
        name              = "Default"
        prefix            = "0.0.0.0/0"
        nexthop_type      = "VirtualAppliance"
        route_nexthop_ips = "10.80.0.68"
      }
    ]
    disable_bgp_route_propagation = true
  },
}

# Subnet_id = Route-Table
route_tablesva_assoc = {
  GatewaySubnet       = "GatewaySubnet"
  AzureFirewallSubnet = "AzureFirewallSubnet"
  snet-commonservices = "internal"
}
