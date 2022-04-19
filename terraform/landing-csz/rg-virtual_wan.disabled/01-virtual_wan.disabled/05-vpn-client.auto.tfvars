

/* User vpn server configurations
# Main fields:
# - location: Location where to deploy resources
# - vpn_authentication_types: Authentication type. Currently only 'AAD' (Azure Active Directory) is supported.
# - azure_ad_audience: Application id of the azure vpn enterprise application registered in your Azure AD tenant.
#                      Registration instructions: https://docs.microsoft.com/en-us/azure/virtual-wan/openvpn-azure-ad-tenant
# - azure_ad_issuer: "https://sts.windows.net/<azure_ad_tenant_id>/"
# - azure_ad_tenant: "https://login.microsoftonline.com/<azure_ad_tenant_id>/"
# - vpn_protocols:  # OPTIONAL # Protocols supported. Supports "IkeV2", "OpenVPN". Both enabled by default.
# - ipsec_policy: # OPTIONAL # IPSEC policy. Do not set to leave Azure defaults.
#
vpn_server_configurations = {
  vpn_ad_auth = {
    location                 = "westeurope"
    vpn_authentication_types = ["AAD"]
    azure_ad_audience        = "5b323e32-6c1e-2145-b397-cd054eded4b1"
    azure_ad_issuer          = "https://sts.windows.net/c31db3c1e-648c-467d-9b44-aec763067gs9/"
    azure_ad_tenant          = "https://login.microsoftonline.com/c31db3c1e-648c-467d-9b44-aec763067gs9/"
    
    vpn_protocols = ["IkeV2", "OpenVPN"]
    
    ipsec_policy = {
      dh_group               = "DHGroup14"
      ike_encryption         = "AES256"
      ike_integrity          = "SHA256"
      ipsec_encryption       = "AES256"
      ipsec_integrity        = "SHA256"
      pfs_group              = "PFS14"
      sa_lifetime_seconds    = "3600"
      sa_data_size_kilobytes = "102400000"
    }
  }
}
*/

vpn_server_configurations = {}

/* Point-To-Site User VPN gateways
# Main fields:
# - location: Location where to deploy resources
# - vpn_server_configuration: VPN configuration defined in `vpn_server_configurations` to apply
# - virtual_hub_name: Name of the virtual hub where to create the gateway
# - scale_unit: Aggregate capacity of the gateway
# - vpn_client_address_pools: List of address pools to use for Point-To-Site User VPNs
# - routing:
#   - associated_route_table_name: Route table to associate (also allows using `default`)
#   - propagated_route_table_names: List of route tables to associate (also allows using `default` and `none`)
#   - labels: # OPTIONAL # List of labels to which to propagate routes
vpn_client_gateways = {
  vpn-client-vhub_01 = {
    location                 = "westeurope"
    vpn_server_configuration = "vpn_ad_auth"
    virtual_hub_name         = "vhub_01"
    scale_unit               = 1
    vpn_client_address_pools = ["172.16.1.0/24"]
    routing = {
      associated_route_table_name  = "rt-vwan-vhub_01-default"
      propagated_route_table_names = ["rt-vwan-vhub_01-default"]
      labels                       = []
    }
  }
}

*/

vpn_client_gateways = {}
