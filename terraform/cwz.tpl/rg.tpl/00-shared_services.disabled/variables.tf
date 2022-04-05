# Terraform Backend state variables required for attachments
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
variable "common_tags" {
  description = "Key/Value of global tags to apply to created resources"
  type        = map(any)
  default     = {}
}

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

variable "admin_objects_ids" {
  description = "Ids of the objects that can do all operations on all keys, secrets and certificates"
  type        = list(string)
  default     = []
}

variable "reader_objects_ids" {
  description = "Ids of the objects that can read all keys, secrets and certificates"
  type        = list(string)
  default     = []
}

variable "custom_rg_name" {
  description = "This is the resource group name under the objects will be created"
  type        = string
  default     = null
}

variable "custom_kv_name" {
  description = "Custom name for Key Vault. By default, it will follow NTT naming convention."
  type        = string
  default     = null
}

variable "custom_rv_name" {
  description = "Custom name for Recovery Vault. By default, it will follow NTT naming convention."
  type        = string
  default     = null
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

# VM backup defaults
variable "vm_backup_policy_timezone" {
  description = "Specifies the timezone for VM backup schedules. Defaults to `UTC`."
  type        = string
  default     = "UTC"
}
variable "vm_backup_policy_time" {
  description = "The time of day to perform the VM backup in 24hour format."
  type        = string
  default     = "04:00"
}
variable "vm_backup_policy_retention_days" {
  description = "The number of daily VM backups to keep. Must be between 7 and 9999."
  type        = number
  default     = 30
}
variable "vm_backup_policy_retention_weeks" {
  description = "The number of weekly backups to keep. Must be between 1 and 9999."
  type        = number
  default     = 4
}
variable "vm_backup_policy_retention_months" {
  description = "The number of monthly backups to keep. Must be between 1 and 9999. Only last week will be kept."
  type        = number
  default     = 12
}
variable "vm_backup_policy_retention_weekdays" {
  description = "The weekday backups to retain. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  type        = list(string)
  default     = ["Sunday"]
}

#Shared Image gallery
variable "images" {
  description = "Shared images definitions"
  type = map(object({
    name      = string // Image name
    os_type   = string // Windows / Linux
    publisher = string // Base image publisher
    offer     = string // Base image offer
    sku       = string // Base image SKU
  }))
  default = {}
}

variable "custom_sig_name" {
  description = "Custom name for the Shared Image gallery"
  type        = string
}

variable "custom_img_name" {
  description = "Custom name for the Image"
  type        = string
}

variable "soft_delete_enabled" {
  description = "(Optional) Is soft delete enable for this Vault?"
  type        = bool
  default     = true
}