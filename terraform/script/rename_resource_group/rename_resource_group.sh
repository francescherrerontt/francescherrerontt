#!/bin/bash

SUBSCRIPTION_ID=$1
RG_DIR=$2
OLD_RG=$3
NEW_RG=$4

TMP_FOLDER="/tmp/rename_azure_rg_$(date +"%Y%m%d_%H%M%S")"


if [[ -z $SUBSCRIPTION_ID || -z $RG_DIR || -z $OLD_RG || -z $NEW_RG ]]; then
    echo "Usage: $0 <SUBSCRIPTION_ID> <RESOURCE_GROUP_DIRECTORY> <ORIGINAL_RG_NAME> <NEW_RG_NAME>"
    exit
fi

if [ "$COMMAND" == "apply" ]; then
    echo
    echo "This will point all your resources in Terraform from '${OLD_RG}' to '${NEW_RG}'."
    echo "THIS PRODCURE IS VERY DANGEROUS. DATA LOSS MIGHT OCCUR. MAKE SURE YOU HAVE A BACKUP OF YOUR CURRENT STATES!"
    read -p "Are you sure you wish to continue? (yes/no): "
    if [ "$REPLY" != "yes" ]; then
        echo "Cancelling..."
        exit
    fi
fi

echo "Working files will be saved to: ${TMP_FOLDER}"

find $RG_DIR -maxdepth 1 -mindepth 1 -type d | while read RG; do
    if [[ "$RG" != *".disabled"* ]]; then

        echo
        echo "###### Applying changes to ${RG} ######"

        echo "Creating folder..."
        TMP_RG_FOLDER="${TMP_FOLDER}/${RG##*/}"
        mkdir -p $TMP_RG_FOLDER

        echo "Downloading current tfstate..."
        ARM_SUBSCRIPTION_ID=$SUBSCRIPTION_ID terraform -chdir=$RG state pull > /$TMP_RG_FOLDER/tfstate.tf
        
        echo "Generating tfstate backup..."
        cp /$TMP_RG_FOLDER/tfstate.tf /$TMP_RG_FOLDER/tfstate.tf.original

        echo "Replacing resource group name..."
        sed -i "s/${OLD_RG}/${NEW_RG}/g" /$TMP_RG_FOLDER/tfstate.tf

        echo "Uploading updated tfstate..."
        ARM_SUBSCRIPTION_ID=$SUBSCRIPTION_ID terraform -chdir=$RG state push -force /$TMP_RG_FOLDER/tfstate.tf

        echo "Done!"
    fi
done
