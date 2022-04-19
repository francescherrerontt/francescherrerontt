/* List of vpn gateways to create

You can add the name of a hub in `virtual_hub_id` and terraform code
will convert it to its corresponding id

For instance:

```
vpn_gateways = {
  vpn_vhub01 = {
    virtual_hub_id = "vhub_01"
    location         = "westeurope"
    scale_unit       = 1

    bgp_settings = {
      asn = 65515
      peer_weight = 0
      instance_0_bgp_peering_address = {
        custom_ips = []
      }
      instance_1_bgp_peering_address = {
        custom_ips = []
      }
    }
  }
}
```
*/

vpn_gateways = {}

/* List of vpn sites to deploy.

For instance:

```
vpn_sites = {
  forti_62 = {
    address_cidrs = []
    device_model  = "Fortinet"
    device_vendor = "Fortigate"

    links = {
      link1 = {
        bgp           = {
          asn = "65000"
          peering_address = "172.16.1.10"
        }
        ip_address    = "52.214.35.196"
        provider_name = "AWS"
        speed_in_mbps = "1000"
      }
    }
  }
  forti_64 = {
    address_cidrs = ["192.168.2.0/24"]
    device_model  = "Fortinet"
    device_vendor = "Fortigate"
    links = {
      link1 = {
        bgp           = {}
        ip_address    = "54.77.213.44"
        provider_name = "AWS"
        speed_in_mbps = "1000"
      }
    }
  }
}
```
*/

vpn_sites = {}

/* List of vpn to vhub connections

For instance:

```
virtual_hub_vpn_connections = {
  cn-vpn-forti62-vhub01 = {
    virtual_hub_name = "vhub_01"
    vpn_gateway_name = "vpn_vhub01"
    vpn_site_name    = "forti_62"

    vpn_links = {
      link1 = {
        vpn_site_link_name = "link1"
        bandwidth_mbps     = 10
        bgp_enabled        = true
        ipsec_policies     = [{
          dh_group                 = "DHGroup14"
          ike_encryption_algorithm = "AES256"
          ike_integrity_algorithm  = "SHA256"
          encryption_algorithm     = "AES256"
          integrity_algorithm      = "SHA256"
          pfs_group                = "PFS14"
          sa_data_size_kb          = "2147483647"
          sa_lifetime_sec          = "28800"
        }]
        protocol                              = "IKEv2"
        ratelimit_enabled                     = true
        route_weight                          = 0
        shared_key                            = "mypresharedkey"
        local_azure_ip_address_enabled        = false
        policy_based_traffic_selector_enabled = false
      }
    }
    internet_security_enabled = false
    routing = {
      associated_route_table_name  = "rt-vwan-vhub_01-default"
      propagated_route_table_names = ["none"]
    }
  }
  cn-vpn-forti64-vhub01 = {
    virtual_hub_name = "vhub_01"
    vpn_gateway_name = "vpn_vhub01"
    vpn_site_name    = "forti_64"

    vpn_links = {
      link1 = {
        vpn_site_link_name = "link1"
        bandwidth_mbps     = 10
        bgp_enabled        = false
        ipsec_policies     = [{
          dh_group                 = "DHGroup14"
          ike_encryption_algorithm = "AES256"
          ike_integrity_algorithm  = "SHA256"
          encryption_algorithm     = "AES256"
          integrity_algorithm      = "SHA256"
          pfs_group                = "PFS14"
          sa_data_size_kb          = "2147483647"
          sa_lifetime_sec          = "28800"
        }]
        protocol                              = "IKEv2"
        ratelimit_enabled                     = true
        route_weight                          = 0
        shared_key                            = "mypresharedkey"
        local_azure_ip_address_enabled        = false
        policy_based_traffic_selector_enabled = false
      }
    }
    internet_security_enabled = false
    routing = {
      associated_route_table_name  = "rt-vwan-vhub_01-default"
      propagated_route_table_names = ["none"]
    }
  }
}
```
*/

virtual_hub_vpn_connections = {}