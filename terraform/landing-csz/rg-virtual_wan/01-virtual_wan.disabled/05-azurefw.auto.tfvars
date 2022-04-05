
/* List of Azure FWs to deploy.

For instance:

```
azurefws = {
  fw-vhub_01 = {
    virtual_hub_name = "vhub_01"
    location         = "westeurope"
    public_ip_count  = 1
  }
}
```
*/

azurefws = {}

/* List of rule collections to add to the Firewall Manager policy

For instance:

```
azurefw_rule_collection_group = {
  customer_rules = {
    priority                     = 100
    application_rule_collections =  {
      blocked_urls = {
        priority = 2100
        action   = "Deny"
        rules    = {
          r_youtube  = {
            protocols         = [
              {
                type = "Http"
                port = "80"
              },
              {
                type = "Https"
                port = "443"
              }            
            ]
            source_ip_groups  = []
            source_addresses  = ["10.81.0.0/22", "10.82.0.0/22"]
            destination_fqdns = ["*.youtube.com"]
          }
          r_google  = {
            protocols         = [
              {
                type = "Http"
                port = "80"
              },
              {
                type = "Https"
                port = "443"
              }             
            ]
            source_ip_groups  = []
            source_addresses  = ["10.81.0.0/22", "10.82.0.0/22"]
            destination_fqdns = ["*.google.com"]
          }
        }
      }
      allow_all_urls = {
        priority = 2199
        action = "Allow"
        rules = {
          r_all  = {
            protocols         = [
              {
                type = "Http"
                port = "80"
              },
              {
                type = "Https"
                port = "443"
              }            
            ]
            source_ip_groups  = []
            source_addresses  = ["10.81.0.0/22", "10.82.0.0/22"]
            destination_fqdns = ["*"]
          }
        }
      }
    }
    network_rule_collections = {
      customer_mgmt = {
        action = "Allow"
        priority = 1100
        rules = {
          icmp_from_customer = {
            protocols             = ["ICMP"]
            destination_ports     = ["*"]
            source_addresses      = ["10.81.0.0/22", "10.82.0.0/22"]
            source_ip_groups      = []
            destination_addresses = ["10.81.0.0/22", "10.82.0.0/22"]
            destination_ip_groups = []
            destination_fqdns     = []
          }
          ssh_from_cwz_to_csz = {
            protocols             = ["TCP"]
            destination_ports     = ["22"]
            source_addresses      = ["10.82.0.0/22"]
            source_ip_groups      = []
            destination_addresses = ["10.81.0.0/22"]
            destination_ip_groups = []
            destination_fqdns     = []
          }
        }
      }
      customer_web = {
        action   = "Allow"
        priority = 1110
        rules    = {
          http_and_https_allow_all = {
            protocols             = ["TCP"]
            destination_ports     = ["80", "443"]
            source_addresses      = ["10.81.0.0/22", "10.82.0.0/22"]
            source_ip_groups      = []
            destination_addresses = ["*"]
            destination_ip_groups = []
            destination_fqdns     = []
          }
        }
      }
    }
  }
  ntt_rules = {
    priority                     = 200
    application_rule_collections =  {
      blocked_urls = {
        priority = 2200
        action   = "Deny"
        rules    = {
          r_youtube = {
            protocols         = [
              {
                type = "Http"
                port = "80"
              },
              {
                type = "Https"
                port = "443"
              }            
            ]
            source_ip_groups  = []
            source_addresses  = ["10.80.0.0/22"]
            destination_fqdns = ["*.youtube.com"]
          }
        }
      }
      allow_all_urls = {
        priority = 2299
        action   = "Allow"
        rules    = {
          r_all  = {
            protocols         = [
              {
                type = "Http"
                port = "80"
              },
              {
                type = "Https"
                port = "443"
              }            
            ]
            source_ip_groups  = []
            source_addresses  = ["10.80.0.0/22"]
            destination_fqdns = ["*"]
          }
        }
      }
    }
    network_rule_collections = {
      ntt_mgmt = {
        action   = "Allow"
        priority = 1200
        rules    = {
          icmp_from_ntt = {
            protocols             = ["ICMP"]
            destination_ports     = ["*"]
            source_addresses      = ["10.80.0.0/22"]
            source_ip_groups      = []
            destination_addresses = ["*"]
            destination_ip_groups = []
            destination_fqdns     = []
          }
          ssh_from_psz = {
            protocols             = ["TCP"]
            destination_ports     = ["22"]
            source_addresses      = ["10.80.0.0/22"]
            source_ip_groups      = []
            destination_addresses = ["*"]
            destination_ip_groups = []
            destination_fqdns     = []
          }
          http_and_https_from_psz = {
            protocols             = ["TCP"]
            destination_ports     = ["80", "443"]
            source_addresses      = ["10.80.0.0/22"]
            source_ip_groups      = []
            destination_addresses = ["*"]
            destination_ip_groups = []
            destination_fqdns     = []
          }
        }
      }
    }
  }
  branch_rules = {
    priority                     = 300
    network_rule_collections = {
      block_server1 = {
        action = "Deny"
        priority = 2300
        rules = {
          icmp_from_branch = {
            protocols             = ["ICMP"]
            destination_ports     = ["*"]
            source_addresses      = ["192.168.0.0/16"]
            source_ip_groups      = []
            destination_addresses = ["10.81.1.4"]
            destination_ip_groups = []
            destination_fqdns     = []
          }
        }
      }
      allow_icmp = {
        action = "Allow"
        priority = 2301
        rules = {
          icmp_from_branch = {
            protocols             = ["ICMP"]
            destination_ports     = ["*"]
            source_addresses      = ["192.168.0.0/16"]
            source_ip_groups      = []
            destination_addresses = ["*"]
            destination_ip_groups = []
            destination_fqdns     = []
          }
        }
      }
    }
  }
  global_rules = {
    priority                     = 400
    network_rule_collections = {
      allow_dns = {
        action = "Allow"
        priority = 2400
        rules = {
          dns = {
            protocols             = ["UDP"]
            destination_ports     = ["53"]
            source_addresses      = ["*"]
            source_ip_groups      = []
            destination_addresses = ["*"]
            destination_ip_groups = []
            destination_fqdns     = []
          }
        }
      }
    }
  }
}
```
*/

azurefw_rule_collection_group = {}