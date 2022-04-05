# Remotestate module

## Introduction

This module belongs to customer-sample NTT main modules and it will create a storage account to save remote states for terraform.

## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14.0 |
| azurerm | ~>2.36.0 |
| random | 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~>2.36.0 |
| external | n/a |
| random | 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| custom\_st\_name | Custom name for storage account for diagnostics | `string` | `null` | no |
| location | This is the location to deploy resources | `string` | `"westeurope"` | no |
| ntt\_auto-cloud-iac | NTT IaC environment identified. Create Automation Managed System per deployment. | `string` | `null` | no |
| ntt\_environment | Productive environment type. Possible values: pro, pre, dev, int, qa, dr | `string` | `"dev"` | no |
| ntt\_monitoring | Defines wether the resources should be monitored or not. Possible values: 0, 1 | `string` | `"1"` | no |
| ntt\_naming-convention | Set to 'true' to autogenerate resource names using NTT naming convention. Name variables will be used as tags inside the names. Set to 'false' to use name variables as resource names | `bool` | `true` | no |
| ntt\_platform | The platform represents a group of systems that underpins one or more critical business functions. This grouping is done per environments (Production, Pre-production, DR, Development, etc.) and per specific functions (DMZ, Backup solution, Marketing site, Email service etc.) | `string` | `null` | no |
| ntt\_service-group | The service group is a category to group CIs that have a similar function in a platform | `string` | `null` | no |
| ntt\_service-level | As defined in Service Now u\_service\_level\_label table: 24x7, EU\_10x5, US\_10x5 | `string` | `"24x7"` | no |
| resource\_group\_name | This is the resource group name under the objects will be created | `string` | `"rg-tfstates"` | no |
| resource\_tags | Key/Value of tags to apply to created resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| container\_name | The name of storage container created |
| resource\_group\_name | The name of resource group created |
| storage\_account\_name | The name of storage account created |
| subscription\_id | The name of storage subscription id created |

## Execution

```shell
terraform init && terraform apply
```
