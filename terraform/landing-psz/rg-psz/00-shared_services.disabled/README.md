# Global Resource Group module

## Introduction

This module belongs to customer-sample NTT main modules and it will do the following actions:
- create a resource group for specific environment.
- create a keyvault for specific environment.

## External module requirements

None.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>2.61.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>2.61.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_recovery_vault"></a> [recovery\_vault](#module\_recovery\_vault) | git::git@scm.capside.com:terraform/azure/terraform-azurerm-recovery-vault.git?ref=ntt/1.0.3 |  |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.global](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.admin_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.readers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.terraform_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_resource_group.global](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_shared_image.packer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) | resource |
| [azurerm_shared_image_gallery.packer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image_gallery) | resource |
| [random_id.kv](https://registry.terraform.io/providers/hashicorp/random/3.1.0/docs/resources/id) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [terraform_remote_state.csz_shared](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_objects_ids"></a> [admin\_objects\_ids](#input\_admin\_objects\_ids) | Ids of the objects that can do all operations on all keys, secrets and certificates | `list(string)` | `[]` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Key/Value of global tags to apply to created resources | `map(any)` | `{}` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Backend container | `string` | n/a | yes |
| <a name="input_custom_img_name"></a> [custom\_img\_name](#input\_custom\_img\_name) | Custom name for the Image | `string` | n/a | yes |
| <a name="input_custom_kv_name"></a> [custom\_kv\_name](#input\_custom\_kv\_name) | Custom name for Key Vault. By default, it will follow NTT naming convention. | `string` | `null` | no |
| <a name="input_custom_rg_name"></a> [custom\_rg\_name](#input\_custom\_rg\_name) | This is the resource group name under the objects will be created | `string` | `null` | no |
| <a name="input_custom_rv_name"></a> [custom\_rv\_name](#input\_custom\_rv\_name) | Custom name for Recovery Vault. By default, it will follow NTT naming convention. | `string` | `null` | no |
| <a name="input_custom_sig_name"></a> [custom\_sig\_name](#input\_custom\_sig\_name) | Custom name for the Shared Image gallery | `string` | n/a | yes |
| <a name="input_images"></a> [images](#input\_images) | Shared images definitions | <pre>map(object({<br>    name      = string // Image name<br>    os_type   = string // Windows / Linux<br>    publisher = string // Base image publisher<br>    offer     = string // Base image offer<br>    sku       = string // Base image SKU<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | This is the location to deploy resources | `string` | `"westeurope"` | no |
| <a name="input_ntt_auto_cloud_iac"></a> [ntt\_auto\_cloud\_iac](#input\_ntt\_auto\_cloud\_iac) | NTT IaC environment identified. Create Automation Managed System per deployment. | `string` | `null` | no |
| <a name="input_ntt_environment"></a> [ntt\_environment](#input\_ntt\_environment) | Productive environment type. Possible values: pro, pre, dev, int, qa, dr | `string` | `"dev"` | no |
| <a name="input_ntt_monitoring"></a> [ntt\_monitoring](#input\_ntt\_monitoring) | Defines wether the resources should be monitored or not. Possible values: 0, 1 | `string` | `"1"` | no |
| <a name="input_ntt_naming_convention"></a> [ntt\_naming\_convention](#input\_ntt\_naming\_convention) | Set to 'true' to autogenerate resource names using NTT naming convention. Name variables will be used as tags inside the names. Set to 'false' to use name variables as resource names | `bool` | `true` | no |
| <a name="input_ntt_platform"></a> [ntt\_platform](#input\_ntt\_platform) | The platform represents a group of systems that underpins one or more critical business functions. This grouping is done per environments (Production, Pre-production, DR, Development, etc.) and per specific functions (DMZ, Backup solution, Marketing site, Email service etc.) | `string` | `null` | no |
| <a name="input_ntt_service_group"></a> [ntt\_service\_group](#input\_ntt\_service\_group) | The service group is a category to group CIs that have a similar function in a platform | `string` | `null` | no |
| <a name="input_ntt_service_level"></a> [ntt\_service\_level](#input\_ntt\_service\_level) | As defined in Service Now u\_service\_level\_label table: 24x7, EU\_10x5, US\_10x5 | `string` | `"24x7"` | no |
| <a name="input_reader_objects_ids"></a> [reader\_objects\_ids](#input\_reader\_objects\_ids) | Ids of the objects that can read all keys, secrets and certificates | `list(string)` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Backend storage resource group | `string` | n/a | yes |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Key/Value of tags to apply to created resources | `map(any)` | `{}` | no |
| <a name="input_soft_delete_enabled"></a> [soft\_delete\_enabled](#input\_soft\_delete\_enabled) | (Optional) Is soft delete enable for this Vault? | `bool` | `true` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Backend storage account | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Backend subscription\_id | `string` | n/a | yes |
| <a name="input_vm_backup_policy_retention_days"></a> [vm\_backup\_policy\_retention\_days](#input\_vm\_backup\_policy\_retention\_days) | The number of daily VM backups to keep. Must be between 7 and 9999. | `number` | `30` | no |
| <a name="input_vm_backup_policy_retention_months"></a> [vm\_backup\_policy\_retention\_months](#input\_vm\_backup\_policy\_retention\_months) | The number of monthly backups to keep. Must be between 1 and 9999. Only last week will be kept. | `number` | `12` | no |
| <a name="input_vm_backup_policy_retention_weekdays"></a> [vm\_backup\_policy\_retention\_weekdays](#input\_vm\_backup\_policy\_retention\_weekdays) | The weekday backups to retain. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday. | `list(string)` | <pre>[<br>  "Sunday"<br>]</pre> | no |
| <a name="input_vm_backup_policy_retention_weeks"></a> [vm\_backup\_policy\_retention\_weeks](#input\_vm\_backup\_policy\_retention\_weeks) | The number of weekly backups to keep. Must be between 1 and 9999. | `number` | `4` | no |
| <a name="input_vm_backup_policy_time"></a> [vm\_backup\_policy\_time](#input\_vm\_backup\_policy\_time) | The time of day to perform the VM backup in 24hour format. | `string` | `"04:00"` | no |
| <a name="input_vm_backup_policy_timezone"></a> [vm\_backup\_policy\_timezone](#input\_vm\_backup\_policy\_timezone) | Specifies the timezone for VM backup schedules. Defaults to `UTC`. | `string` | `"UTC"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_keyvault_id"></a> [keyvault\_id](#output\_keyvault\_id) | The ids of keyvault created |
| <a name="output_keyvault_uri"></a> [keyvault\_uri](#output\_keyvault\_uri) | The uri of keyvault created |
| <a name="output_recovery_services_vault_name"></a> [recovery\_services\_vault\_name](#output\_recovery\_services\_vault\_name) | The name of the Recovery Services Vault |
| <a name="output_resource_group_location"></a> [resource\_group\_location](#output\_resource\_group\_location) | Resource group location |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Resource group name |
| <a name="output_vm_backup_policy_id"></a> [vm\_backup\_policy\_id](#output\_vm\_backup\_policy\_id) | VM Backup policy ID |


## Execution

```shell
 terraform init -backend-config ../../../backend.tfvars  && terraform apply -var-file ../../common.tfvars -var-file ../group.tfvars
```
