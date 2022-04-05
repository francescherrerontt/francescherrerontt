# Terraform Backend state variables required when attachments
variable "resource_group_name" {
  description = "Backend storage resource group"
  type        = string
}
variable "storage_account_name" {
  description = "Backend storage account"
  type        = string
}

variable "container_name" {
  description = "Backend container"
  type        = string
}

variable "subscription_id" {
  description = "Backend subscription_id"
  type        = string
}

# Resources default tag
variable "resource_tags" {
  description = "Key/Value of tags to apply to created resources"
  type        = map(any)
  default     = {}
}

variable "location" {
  description = "This is the location to deploy resources"
  type        = string
  default     = "westeurope"
}

variable "nsg" {
  description = "Custom map for several nsg"
  type        = map(any)
  default     = {}
}

variable "custom_vnet_name" {
  description = "Custom name for the virtual network"
  type        = string
  default     = null
}

variable "custom_firewall_name" {
  description = "Custom name for the firewall"
  type        = string
  default     = null
}

variable "nsg_assoc" {
  description = "Associates security groups to "
  type        = map(any)
  default     = {}
}

variable "subnet_objects" {
  description = "List of subnet objects"
  type = list(object({
    name   = string
    prefix = string
  }))
  default = []
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = string
}

variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(any)
  default     = []
}

variable "route_tablesva" {
  description = "Custom map for route tables supporting Virtual appliance"
  type        = map(any)
  default     = {}
}

variable "route_tablesva_assoc" {
  description = "List of associations between route tables and subnets"
  type        = map(any)
  default     = {}
}

variable "route_tables" {
  description = "Custom map for route tables supporting Valid values are 'VirtualNetworkGateway', 'VnetLocal', 'Internet', 'HyperNetGateway', 'None'"
  type        = map(any)
  default     = {}
}

variable "firewall_application_rules" {
  description = "List of application rules to apply to firewall."
  type        = map(any)
  default     = {}
}

variable "firewall_network_rules" {
  description = "List of network rules to apply to firewall."
  type        = map(any)
  default     = {}
}

variable "firewall_nat_rules" {
  description = "List of nat rules to apply to firewall."
  type        = map(any)
  default     = {}
}

variable "ntt_monitoring" {
  description = "Defines wether the resources should be monitored or not. Possible values: 0, 1"
  type        = string
  default     = "1"
  validation {
    condition     = can(regex("^[01]$", var.ntt_monitoring))
    error_message = "The value of ntt_monitoring must be 0 or 1."
  }

}
variable "ntt_environment" {
  description = "Productive environment type. Possible values: pro, pre, dev, int, qa, dr"
  type        = string
  default     = "dev"
  validation {
    condition     = can(regex("^(pro|pre|int|dev|qa|dr)$", var.ntt_environment))
    error_message = "The vaue of ntt_environment must be one of: pro, pre, dev, int, qa, dr."
  }
}
variable "ntt_platform" {
  description = "The platform represents a group of systems that underpins one or more critical business functions. This grouping is done per environments (Production, Pre-production, DR, Development, etc.) and per specific functions (DMZ, Backup solution, Marketing site, Email service etc.)"
  type        = string
  default     = null
}
variable "ntt_service_group" {
  description = "The service group is a category to group CIs that have a similar function in a platform"
  type        = string
  default     = null
}
variable "ntt_service_level" {
  description = "As defined in Service Now u_service_level_label table: 24x7, EU_10x5, US_10x5"
  default     = "24x7"
  validation {
    condition     = can(regex("^(24x7|EU_10x5|US_10x5)$", var.ntt_service_level))
    error_message = "The vaue of ntt_service_level must be one of: 24x7, EU_10x5, US_10x5."
  }
}
variable "ntt_auto_cloud_iac" {
  description = "NTT IaC environment identified. Create Automation Managed System per deployment."
  type        = string
  default     = null
}
variable "ntt_naming_convention" {
  description = "Set to 'true' to autogenerate resource names using NTT naming convention. Name variables will be used as tags inside the names. Set to 'false' to use name variables as resource names"
  type        = bool
  default     = true
}
variable "delegations" {
  description = "A map with key (string) `subnet name`, value (map of delegations for this subnet) to indicate delegations to create. Default value is {}."
  type        = map(any)
  default     = {}
}
variable "subnet_enforce_private_link_endpoint_network_policies" {
  description = "A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false."
  type        = map(bool)
  default     = {}
}
variable "subnet_service_endpoints" {
  description = "A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is {}."
  type        = map(list(string))
  default     = {}
}
