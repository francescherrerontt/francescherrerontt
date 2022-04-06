resource "random_id" "prefix" {
  byte_length = 8
}


/* group previously created in AAD
data "azuread_group" "aks_cluster_admins" {
  display_name = "akscluster"
}
*/

resource "azurerm_user_assigned_identity" "test" {
  resource_group_name = data.terraform_remote_state.global_rg.outputs.resource_group_name
  location            = data.terraform_remote_state.global_rg.outputs.resource_group_location
  name                = "${random_id.prefix.hex}-identity"
}

/* cluster kubenet */
module "aks_cluster" {
  for_each                         = var.aks_kubenet
  source                           = "git@scm.capside.com:terraform/azure/terraform-azurerm-aks.git?ref=4.13.0"
  cluster_name                     = var.ntt_naming_convention ? lower(substr(format("aks-%s-%s", var.ntt_environment, each.key), 0, 60)) : each.key
  prefix                           = each.key
  resource_group_name              = data.terraform_remote_state.global_rg.outputs.resource_group_name
  kubernetes_version               = each.value.kubernetes_version
  orchestrator_version             = each.value.orchestrator_version
  enable_role_based_access_control = true # it will require to redeploy the cluster
  #rbac_aad_admin_group_object_ids  = [data.azuread_group.aks_cluster_admins.id]
  rbac_aad_managed                     = true
  enable_log_analytics_workspace       = true
  cluster_log_analytics_workspace_name = each.key

  os_disk_size_gb                 = each.value.os_disk_size_gb # changes here implies a redeployment
  enable_http_application_routing = false                      #not recommended for production
  enable_azure_policy             = false                      # not supported if network plugin is kubenet
  enable_host_encryption          = false                      # EncryptionAtHost It has to be enabled explicitly at subscription level
  sku_tier                        = "Paid"
  agents_size                     = each.value.agents_size # changes here implies a redeployment
  private_cluster_enabled         = false
  enable_auto_scaling             = true
  agents_min_count                = each.value.agents_min_count
  agents_max_count                = each.value.agents_max_count
  agents_count                    = null # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
  agents_max_pods                 = each.value.agents_max_pods
  agents_pool_name                = each.key
  agents_availability_zones       = ["1", "2", "3"] # changes here implies a redeployment
  agents_type                     = "VirtualMachineScaleSets"
  agents_labels                   = each.value.agents_labels
  agents_tags                     = each.value.agents_tags

  enable_kube_dashboard     = false
  net_profile_pod_cidr      = "10.1.0.0/16"
  identity_type             = "UserAssigned"
  user_assigned_identity_id = azurerm_user_assigned_identity.test.id

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}


# node pool
resource "azurerm_kubernetes_cluster_node_pool" "internal" {
  for_each              = var.aks_resource_pool
  name                  = each.key
  kubernetes_cluster_id = module.aks_cluster[each.value.aks].aks_id
  vm_size               = each.value.agents_size

  enable_auto_scaling = true
  min_count           = each.value.agents_min_count
  max_count           = each.value.agents_max_count
  max_pods            = each.value.agents_max_pods
  availability_zones  = each.value.agents_availability_zones

  node_labels = each.value.agents_labels
  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}

/*
#nodepool spot
resource "azurerm_kubernetes_cluster_node_pool" "spot" {
  name                  = "spot"
  kubernetes_cluster_id = module.aks_cluster.aks_id
  vm_size               = "Standard_D2_v3"

  enable_auto_scaling = true
  min_count           = 3
  max_count           = 5
  max_pods            = 40
  availability_zones  = ["1", "2"]
  priority            = "Spot"
  eviction_policy     = "Delete"

  node_labels = {
    "kubernetes.azure.com/scalesetpriority" = "spot"
    "environment"                           = "spot"
    "nodetype"                              = "user"
  }
  node_taints = ["kubernetes.azure.com/scalesetpriority=spot:NoSchedule"]

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}
*/

/*cluster with azure cni
module "aks_cni" {
  source                           = "git@scm.capside.com:terraform/azure/terraform-azurerm-aks.git?ref=4.13.0"
  prefix                           = "prefix-${random_id.prefix.hex}"
  resource_group_name              = data.terraform_remote_state.global_rg.outputs.resource_group_name
  kubernetes_version               = "1.21.7"
  orchestrator_version             = "1.21.7"
  network_plugin                   = "azure"
  enable_role_based_access_control = true # it will require to redeploy the cluster
  #rbac_aad_admin_group_object_ids  = [data.azuread_group.aks_cluster_admins.id]
  rbac_aad_managed = true
  #vnet_subnet_id                  = "/subscriptions/xyz/resourceGroups/nmo/providers/Microsoft.Network/virtualNetworks/vnet-pro-poq/subnets/snet-aks"
  os_disk_size_gb                 = 60    # changes here implies a redeployment
  enable_http_application_routing = false #not recommended for production
  enable_azure_policy             = true  # not supported if network plugin is kubenet
  enable_host_encryption          = false # EncryptionAtHost It has to be enabled explicitly at subscription level
  sku_tier                        = "Paid"
  private_cluster_enabled         = false
  enable_auto_scaling             = true
  agents_min_count                = 2
  agents_max_count                = 4
  agents_count                    = null # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
  agents_max_pods                 = 60
  agents_pool_name                = "testnodepool"
  agents_availability_zones       = ["1", "2"] # changes here implies a redeployment
  agents_type                     = "VirtualMachineScaleSets"

  agents_labels = {
    "node1" : "label1"
  }

  agents_tags = {
    "Agent" : "agentTag"
  }

  network_policy                 = "azure"
  net_profile_dns_service_ip     = "10.0.0.10"
  net_profile_docker_bridge_cidr = "170.10.0.1/16"
  net_profile_service_cidr       = "10.0.0.0/16"
}
*/
