# rename_resource_group.sh

This script can be used to rename resource groups. Anyway, it is not recommended to use it. Instead, it is recommended to rebuild the platform when possible using the correct names.

**THIS SCRIPT IS EXTREMELY DANGEROUS. ONLY USE IF REALLY REQUIRED**

## What the script does

* Downloads the current tfstates for the affected resource group
* Updates the name of the resouce group (bulk replace from one name to another. If other objects are named the same, might be renamed too...)
* Uploads the updated tfstates for the affected group into the same container folder where they originally were

## What the script does **NOT** do

* Rename folder names in terraform structure (if you move from `rg-source` to `rg-destination`, you have to manually rename the folder in the repo).
* Rename the folder in the tfsates container where the different tfstates are. If this needs to be renamed, you will need to manually update all `attachments.tf` and `remotestate.tf` files to point to the new location, and manually move the tfstate to the new folder.

## Considerations

* The script replaces the tfstates in bulk, not taking into account if there are other resources with the same name as the original resource group.
* The effect of using this script to replace other things different than a resource group is unknown.
* Moving things from one resource group to another might cause some resources to be recreated (ie. diagnostic settings, etc.).

## Pre-requisites

* A backup of the current remote tfstates exist (versioning on the storage account should be on)
* Validate that all resources in the resouce group can be moved to a new resource group

## Usage

Create the new resource group manually in the Azure portal.

Move all resources to the new resource group via the portal.

Delete the old resource group manually in the Azure portal.

Execute the script as follows:

```bash
bash rename_resource_group.sh <SUBSCRIPTION_ID> <RESOURCE_GROUP_DIRECTORY> <ORIGINAL_RG_NAME> <NEW_RG_NAME>
```

> A backup of the downloaded tfstate is kept in `/tmp/rename_azure_rg_<DATE>/<DIRECTORY>/tfstate.tf.original`

For instance:
```bash
$ bash rename_resource_group.sh da31fec5-a980-41e9-a3b8-e99f5099173c ../../../terraform/landing-davidb-20211216/rg-davidb-20211216/ rg-test-davidb-source rg-test-davidb-destination
Working files will be saved to: /tmp/rename_azure_rg_20211217_001659

###### Applying changes to ../../../terraform/landing-davidb-20211216/rg-davidb-20211216/00-shared_services ######
Creating folder...
Downloading current tfstate...
Generating tfstate backup...
Replacing resource group name...
Uploading updated tfstate...
Done!

###### Applying changes to ../../../terraform/landing-davidb-20211216/rg-davidb-20211216/01-virtual_network ######
Creating folder...
Downloading current tfstate...
Generating tfstate backup...
Replacing resource group name...
Uploading updated tfstate...
Done!

###### Applying changes to ../../../terraform/landing-davidb-20211216/rg-davidb-20211216/10-virtual_machine ######
Creating folder...
Downloading current tfstate...
Generating tfstate backup...
Replacing resource group name...
Uploading updated tfstate...
Done!

```

Update the resource group name in `00-shared_services/00-main.tf` of the affected resource group.

For instance:

```hcl
resource "azurerm_resource_group" "global" {
  name     = "rg-test-davidb-destination" # NEW NAME GOES HERE
  location = var.location
  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}
```

From the `terraform` folder, execute an apply to confirm the changes have worked as expected.

For instance:

```bash
$ make tf-apply-davidb-20211216-rg-davidb-20211216
```

Once you have confirmed everything looks good, you can delete the temporary folder created under `/tmp/rename_azure_rg_<DATE>/`

