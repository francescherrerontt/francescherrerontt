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

/*AKS*/

variable "aks_kubenet" {
  description = "This is the AKS definition map using kubenet"
  type        = map(any)
  default     = {}
}

variable "aks_resource_pool" {
  description = "This is the AKS definition map using kubenet"
  type        = map(any)
  default     = {}
}


variable "agents_size" {
  default     = "Standard_D2s_v3"
  description = "The default virtual machine size for the Kubernetes agents"
  type        = string
}

variable "os_disk_size_gb" {
  description = "Disk size of nodes in GBs."
  type        = number
  default     = 50
}

variable "kubernetes_version" {
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
  type        = string
  default     = null
}

variable "orchestrator_version" {
  description = "Specify which Kubernetes release to use for the orchestration layer. The default used is the latest Kubernetes version available in the region"
  type        = string
  default     = null
}

variable "agents_max_count" {
  type        = number
  description = "Maximum number of nodes in a pool"
  default     = null
}

variable "agents_min_count" {
  type        = number
  description = "Minimum number of nodes in a pool"
  default     = null
}

variable "agents_availability_zones" {
  description = "(Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
  type        = list(string)
  default     = null
}

variable "agents_labels" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created."
  type        = map(string)
  default     = {}
}

variable "agents_tags" {
  description = "(Optional) A mapping of tags to assign to the Node Pool."
  type        = map(string)
  default     = {}
}

variable "agents_max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type        = number
  default     = null
}