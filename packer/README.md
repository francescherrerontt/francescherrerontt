# Introduction

This is a packer images sample repository for windows and linux operating systems supported by NTT.


# Instructions usage

- Create a credentials file called '05-secret.pkrvars.hcl' with your Azure login details. For instance:

```
# cat 05-secret.pkrvars.hcl
az_subscription_id = "83c6fa30-xxxx-yyyy-zzzz-c9c687d8ae0b"
az_tenant_id = "6de8462f-fdd9-xxxx-yyyy-9f7d611fb09b"
az_client_id = "0aa216d7-1e05-xxxx-yyyy-5eda34a7ab9b"
az_client_secret = "a2bd29e1-xxxx-yyyy-zzzz-44bd39ac1616"
```

- Build image.

```
packer build  -var-file="w19.pkrvars.hcl" -var-file="secret.pkrvars.hcl" windows.pkr.hcl 
```