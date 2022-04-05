# These variables are "Landing Zone-wide". By default all the resources deployed
# inside the landing zone will have these values.
#
# You can use individual tfvars files for each of the resources or deployments to
# override these values
location           = "westeurope"
ntt_monitoring     = "1"
ntt_environment    = "pro"
ntt_platform       = "mgmt"
ntt_service_group  = "psz"
ntt_service_level  = "EU_10x5"
ntt_auto_cloud_iac = "GEN000XXXXXX"
