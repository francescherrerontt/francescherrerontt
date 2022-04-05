# vm_scale_set module

## Introduction

This module belongs to customer-sample NTT main modules and it will do actions related to virtual machine scale sets like, the following:
- create public ips
- create vm scale sets
- create nsg
- create load balancer

## External module requirements

- [terraform-azurerm-vm-scale-set-ntt](ssh://git@code.nttcom.ms:7999/product/terraform/staging/terraform-azurerm-vm-scale-sets.git?ref=ntt)

## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.13.3 |
| azurerm | ~>2.27.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~>2.27.0 |
| random | n/a |
| terraform | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| container\_name | Backend container | `string` | n/a | yes |
| location | This is the location to deploy resources | `string` | `"westeurope"` | no |
| ntt\_auto-cloud-iac | NTT IaC environment identified. Create Automation Managed System per deployment. | `string` | `null` | no |
| ntt\_environment | Productive environment type. Possible values: pro, pre, dev, int, qa, dr | `string` | `"dev"` | no |
| ntt\_monitoring | Defines wether the resources should be monitored or not. Possible values: 0, 1 | `string` | `"1"` | no |
| ntt\_naming-convention | Set to 'true' to autogenerate resource names using NTT naming convention. Name variables will be used as tags inside the names. Set to 'false' to use name variables as resource names | `bool` | `true` | no |
| ntt\_platform | The platform represents a group of systems that underpins one or more critical business functions. This grouping is done per environments (Production, Pre-production, DR, Development, etc.) and per specific functions (DMZ, Backup solution, Marketing site, Email service etc.) | `string` | `null` | no |
| ntt\_service-group | The service group is a category to group CIs that have a similar function in a platform | `string` | `null` | no |
| ntt\_service-level | As defined in Service Now u\_service\_level\_label table: 24x7, EU\_10x5, US\_10x5 | `string` | `"24x7"` | no |
| resource\_group\_name | Backend storage resource group | `string` | n/a | yes |
| resource\_tags | Key/Value of tags to apply to created resources | `map(any)` | `{}` | no |
| ssh\_key | Path to the public key to be used for ssh access to the VM. | `string` | `"~/.ssh/id_rsa.pub"` | no |
| storage\_account\_name | Backend storage account | `string` | n/a | yes |
| subscription\_id | Backend subscription\_id | `string` | n/a | yes |
| vm\_scale\_set\_l | This is the linux scale set definition map | `map(any)` | `{}` | no |
| vm\_scale\_set\_w | This is the windows scale set definition map | `map(any)` | `{}` | no |

## Outputs

No output.


## Execution

```
 terraform init -backend-config ../../../backend.tfvars  && terraform apply -var-file ../../common.tfvars -var-file ../../../backend.tfvars -var-file ../group.tfvars
```