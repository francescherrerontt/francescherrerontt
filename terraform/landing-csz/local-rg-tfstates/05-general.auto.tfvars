resource_group_name = "rg-tfstates"

location          = "westeurope"
ntt_monitoring    = "1"
ntt_environment   = "pro"
ntt_platform      = "mgmt"
ntt_service_group = "state"
ntt_service_level = "EU_10x5"

# For future usage
#ntt_auto_cloud_iac = "GEN000XXXXXX"

# Add random tags
resource_tags = {
  ntt_owner = "Product Engineering"
}
