
route_tablesva = {
  "internal" = {
    routes = [
      {
        name              = "Default"
        prefix            = "0.0.0.0/0"
        nexthop_type      = "VirtualAppliance"
        route_nexthop_ips = "10.80.0.68"
      }
    ]
    disable_bgp_route_propagation = false
  },
}

# Subnet_id = Route-Table
route_tablesva_assoc = {
  snet-psz = "internal"
}
