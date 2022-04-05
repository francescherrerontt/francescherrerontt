# Project Skeleton

[[_TOC_]]

## Introduction

This is a customer sample terraform structure to be reused as a template for the different NTT deployments.
The objective is to try to reuse as much as possible the following building blocks which will be used as a common standard inside the company.

Two different methods of deployment exist:

* **Automated (GitOps)**: Deployment is performed using Gitlab-CI pipelines. Code is modified locally and changes are executed by GitLab-CI.
* **Manual**: Deployment of all environment is performed locally from your computer

## Pre-Requisites

* A customer repository has been created in Gitlab.

## Considerations/Recommendations

### About multi-directory deployments

For non trivial deployments, we split the resource group (logical grouping of cloud objects)
in several subdirectories, each one of them containing the logical resources (virtual network,
virtual machines, ...).

For such deployments, the Make targets **execute the Terraform operations sequentially
in each subdirectory**. That means that you need to be explicitly aware of the
inter-dependencies, and use prefix numbers for the targets to execute each one on the
correct order (`00-shared_services`, `01-virtual_network`, ...).

As all the resources are going to be disabled by default you will have to apply changes in phases when there are dependencies between resources
in different directories after removing the .disabled section in the folder name(for instance, if creating a new *customer work zone*, create the
networks first and the virtual machines later.)

### Disable resources

To disable a specific resource inside a landing resource group, the resource directory name must
end with `*.disabled`. For example, `landing-csz/rg-123/00-virtual_network.disabled`. This naming,
will be used by the Makefile to exclude the corresponding directories from any of the Makefile
targets operations (init, validate, plan, apply and **destroy**).

In addition, the same approach can be applied to the whole resource groups, for example, `landing-csz/rg-123.disabled`.


### Downloading the code template

To populate your repository with the project skeleton template code, you should do the following:

> Replace `$repository_url` with the url of your customer repository and `$repository_name` with the name your customer repository.

```sh
git clone $repository_url
cd $repository_name
git archive --remote ssh://git@scm.capside.com/terraform/azure/project-skeleton.git HEAD | tar -x
mv .gitignore.customer.sample .gitignore
git add -A
git commit -m 'Initial project import'
```

Now you can continue working on the code and push it to the repo when required.

### Structure

The structure of the repository is the following:

```txt
└── terraform
    ├── cwz.tpl
    │   └── rg.tpl
    │       ├── 00-shared_services.disabled
    │       ├── 01-virtual_network.disabled
    │       ├── 10-virtual_machine.disabled
    │       │   └── scripts
    │       ├── 15-load_balancer.disabled
    │       ├── 20-vm_scale_set.disabled
    │       ├── 30-app_service.disabled
    │       ├── 35-sql_server.disabled
    │       ├── 40-service_bus.disabled
    │       ├── 45-cosmos_db.disabled
    │       └── 90-virtual_wan_connection.disabled
    ├── landing-csz
    │   ├── local-rg-tfstates
    │   ├── rg-csz
    │   │   ├── 00-shared_services.disabled
    │   │   ├── 01-virtual_network.disabled
    │   │   ├── 10-virtual_machine.disabled
    │   │   │   └── scripts
    │   │   └── 90-virtual_wan_connection.disabled
    │   └── rg-virtual_wan
    │       ├── 00-shared_services.disabled
    │       └── 01-virtual_wan.disabled
    ├── landing-psz
    │   └── rg-psz
    │       ├── 00-shared_services.disabled
    │       ├── 01-virtual_network.disabled
    │       ├── 10-virtual_machine.disabled
    │       │   └── scripts
    │       └── 90-virtual_wan_connection.disabled
    └── script

```

The subdirectories are separated in **landing zones**, which can span across
different subscriptions, depending on the size of the customer. Under each landing,
each directory corresponds to a **resource group deployment**. Every resource group
directory can have either Terraform files directly, or subdirectories per each type
of service (virtual machines, network, global resources, etc.).

There are several fixed directories that match [NTT Blueprints](https://scm.capside.com/technology-strategy/blueprints) worth explaining:

* **`landing-csz`**: Customer Shared services Zone
  * **`local-rg-tfstates`**: Deployment to bootstrap the Terraform remote state
  files, used by all other deployments.
  * **`rg-csz`**: Shared services deployed by NTT (VPN, ExpressRoute, ...)
* **`landing-psz`**: NTT Management Zone (Automation server, Logic Monitor, Remote
  Access, ...)
* **`landing-cwz.tpl`**: Template directory for a Customer Workload landing zone.

### Modifications needed

After creating the new customer directory from the project skeleton template, **you
need to review and modify accordingly**:

* **SUBSCRIPTION_ID**: For each landing, edit the `Makefile` and set the subscription
  where that landing will be deployed in. (ex: `SUBSCRIPTION_ID := f9818f98-857b-4358-abf0-b4cd3a207682`)
* **landing.tfvars**: for each landing, review the global defined variables that apply to
  all deployments.
* **group.tfvars**: to define resource group specific values.
* **05-general.auto.tfvars**: to define general values inside the main module.
* **00-module.tf** : to define specific values inside module definitions.
    ie: `00-modules.tf` will define that all the linux VMs deployed will be using specific operating system image.
* **05-moduletype.auto.tfvars**: to define specific variables from specific features of the main module.
    ie: `05-linuxvm.auto.tfvars` will define specific properties for the linux VMs deployed.
* You may enable or disable features of the module depending on your needs.
* In case of multiple environments/subscriptions, you might need to modify 'remotestate.tf' and 'attachments.tf' with the configuration according to your environment.
* Configuration included in this skeleton is disabled by default. To enable the deployments, you will need to rename the following folders according to your needs, removing the trailing .disabled:
  * terraform/landing-\*/\*/\*.disabled
* There is a **failsafe file** in the `rg-tfstates` from the CSZ landing to make sure you
  review the code and variables before trying to blind-deploy. It will just
  issue an error, so you will need to remove the [fail.tf](./terraform/landing-csz/local-rg-tfstates/fail.tf) file.

Most resource **names are generated or modified automatically** following [NTT best
practices](https://msd.confluence.nttltd.global.ntt/display/public/OT/STD+-+Azure+-+Naming+Conventions).
Names defined in variable files are used as tags inside the name of the resource. If
there is a specific naming convention for a particuar client, set
`ntt_naming_convention` variable to `false` so name variables are used directly as
resource names.

Example:

If the variable for a route table name is `internal` and `ntt_naming_convention` is set to `true`, the name of the VM will be something like:

```jinja2
{{objectnameprefix}}_{{ntt_environment}}_{{ntt_service_group}}_internal
```

Like:

```txt
route-pro-backend-internal
```

And if `ntt_naming_convention` is set to `false`, the name of the route will be:

```txt
internal
```

We should minimize as much as possible custom edits of other resources in order to achieve a common/standardized way of deploying resources.

If you need an additional resource or feature please inform the IaC team.

In order to build new resources/features we should follow [NTT style guide](https://scm.capside.com/capside/style-guides/-/blob/master/terraform-modules-lifecycle.md) and [Coding best practices](https://confluence.ntt.eu/display/devel/Terraform)

### VPN

VPN configuration is included in this skeleton, but it's **disabled by default**. To
enable the VPN deployments in both the CSZ and the PSZ, you will need to rename the
following files, removing the trailing `.disabled`:

* [00-vpn.tf.disabled](terraform/landing-psz/rg-psz/01-virtual_network/00-vpn.tf.disabled)
* [05-vpn.auto.tfvars.disabled](terraform/landing-psz/rg-psz/01-virtual_network/05-vpn.auto.tfvars.disabled)
* [00-vpn.tf.disabled](terraform/landing-csz/rg-csz/01-virtual_network/00-vpn.tf.disabled)
* [05-vpn.auto.tfvars.disabled](terraform/landing-csz/rg-csz/01-virtual_network/05-vpn.auto.tfvars.disabled)

This skeleton has pre-set variables to configure the VPN connections for both zones,
so you should **review and modify them** accordingly:

* [terraform/landing-psz/rg-psz/01-virtual_network/05-vpn.auto.tfvars.disabled](terraform/landing-psz/rg-psz/01-virtual_network/05-vpn.auto.tfvars.disabled)
* [terraform/landing-csz/rg-csz/01-virtual_network/05-vpn.auto.tfvars.disabled](terraform/landing-csz/rg-csz/01-virtual_network/05-vpn.auto.tfvars.disabled)

### ExpressRoute

ExpressRoute configuration is included in the skeleton, but it's **disabled by
default**. To enable it, you will need to remove the trailing `.disabled` from the files:

* [00-expressroute.tf.disabled](terraform/landing-csz/rg-csz/01-virtual_network/00-expressroute.tf.disabled)
* [05-expressroute.tfvars.disabled](terraform/landing-csz/rg-csz/01-virtual_network/05-expressroute.auto.tfvars.disabled)

**Be sure to review the configuration variables** in
[05-expressroute.tfvars.disabled](terraform/landing-csz/rg-csz/01-virtual_network/05-expressroute.auto.tfvars.disabled),

Be aware that **the circuit needs to be provisioned before the
connection can be created**. The first iteration will create the circuit and the
ExpressRoute Virtual Network Gateway, and will provide the service key
(`expressroute_circuit_service_key`) required to provision the circuit. Once the
circuit has been provisioned, change `expressroute_circuit_provisioned` variable in
[05-expressroute.auto.tfvars.disabled](terraform/landing-csz/rg-csz/01-virtual_network/05-expressroute.auto.tfvars.disabled) to `true` **and re-apply the
configuration again**. This will create the missing required connections.

In case the circuit id is already provisioned and should not be managed via
Terraform, you can provide the circuit id via `expressroute_circuit_id` variable in
[05-expressroute.auto.tfvars.disabled](terraform/landing-csz/rg-csz/01-virtual_network/05-expressroute.auto.tfvars.disabled).
This will prevent the creation of a new circuit via terraform, and use this one
instead. **Note: This option still requires `expressroute_circuit_provisioned` to be
set to `true`**.

### Virtual WAN

It is possible to use Virtual WAN to interconnect vnets and create vpns. It is also possible to configure an Azure FW in a Virtual Hub and manage it using Firewall Manager.

> This is not a standard deployment. If you use Virtual WAN with Azure FW in a Virtual Hub, remember to remove the configuration related to Azure FW from the csz (as that is deploying an Azure FW in the csz vnet instead of the Virtual Hub), and the vnet peering configuration from all other subnets.

Virtual WAN configuration can be found under:

```bash
landing-csz/rg-virtual_wan
```

**It is mandatory that you deploy Virtual WAN before any other landing (csz, psz...)**

You can deploy it using:

```bash
make tf-<ACTION>-csz-rg-virtual_wan
```

or using automated pipelines

> Remember to uncomment it in .gitlab-ci.env.yml

VNET to Virtual Hub connection configuration can be found under each respective landing configuration folder.

```bash
landing-<LANDING>/rg-<RESOURCE_GROUP>/90-virtual_wan_connection
```

#### Creating Customer Workload Zones

There is a "template" directory with a basic structure for a CWZ (Customer
Workload Zone). That directory [cwz.tpl](terraform/cwz.tpl) is not meant to be directly
deployed, and it's only used as a base template as a starting point to create new
actual workload landings.

The easiest way to create a new ResourceGroup within a Workload Zone is to use the
Makefile dynamic target (note that angle brackets should not be part of your name,
we're only showing them to make it clear what are the different parts):

```sh
make cwz-<workload-name>_<resource-group-name>
```

We use underscores to separate the two main parts to generate the directories and do
some basic variable substitution:

* **workload-name**: This is the "landing zone name". This is used as follows:
  * `landing-<workload-name>` directory will be created
  * `landing-<workload-name>/landing.tfvars` will set the `ntt_platform` variable to
  `"<workload-name>"`, and `ntt_service_group` to `"<resource-group-name>"`.
* **resource-group-name**: This is a "service group" or resource group that will be
  created inside the `<workload-name>` landing zone. This is used as follows:
  * `landing-<workload-name>/rg-<resource-group-name>` directory will be created.
  * `landing-<workload-name>/rg-<resource-group-name>/group.tfvars` will set `ntt_platform` to
  `"<workload-name>"` and `ntt_service_group` to `"<resource-group-name>"`.

The process will also set up names for the Terraform remote state and attachment files, following
the same pattern. For example, the contents of
`landing-workload-name/rg-resource-group-name/00-shared_services/remotestate.tf` will
be:

```hcl
terraform {
  backend "azurerm" {
    key = "workload-name/resource-group-name/shared/terraform.tfstate"
  }
}
```

The first time you call it, it will create both the landing directory and the initial
Resource Group directory as described above. Further executions when `workload-name`
has been already initialised as a lansing zone will only create new Resource Group
directories inside the landing directory, setting the `ntt_service_group` variable to
the contents of the second part of the target. For example, if after executing the
previous example, you then execute the following:

```sh
make cwz-workload-name_ecommerce
```

It will only create `landing-workload-name/rg-ecommerce`, and will set
`ntt_service_group` to `"ecommerce"` in the
`landing-workload-name/rg-ecommerce/group.tfvars` file.

Even when there's some degree of automation, **you should review all contents** in
the files created to adapt variable values, deployments, etc.

## Execution steps

### Bootstrap

The first step for a new project is to bootstrap the Terraform state files container
in a storage account. To do that, **after you review the vars files for naming**:

```sh
cd terraform
make bootstrap
```

This step **always needs to be performed locally**, even if using automated pipelines.

### Automated execution (GitOps)

Execution is triggered via GitLab-CI pipelines (with the exception of *bootstrap* configuration required to store *tfstate* files in an S3 bucket).

There are two types of automated executions supported:

* **Without manual approval**: Once the Merge Request is merged into master, code is deployed directly without confirmation.
* **With manual approval**: Once the Merge Request is merged into master, a *plan* is executed so you can re-evaluate the changes that will be performed. Once they have been reviewed, you have to manually accept those changes (by clicking the play *>* button next to the *apply* jobs).

> Directories without changes will be skipped automatically. Only directories with changes will be applied (the only exception to this is when executing a pipeline manually. In such an event, all directories will be applied).

You can enable/disable manual approval by setting `APPROVAL_REQUIRED` as described in [Configuring the customer repository in Gitlab (Automated deployments only)](#configuring-the-customer-repository-in-gitlab-automated-deployments-only) section.

#### Configuring the customer repository in Gitlab (Automated deployments only)

When using automated deployment with Gitlab-CI pipelines, you will need to perform the following changes in your Gitlab repository.

> A Service Principal with enough permissions to deploy all code managed by Terraform is required. Instructions on how to set it up can be found [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret).

* Configure the following variables **(Settings/"CI/CD"/Variables)**:

| Variable                | Description                                         | Example |
| ---                     | ---                                                 | ---     |
| TERRAFORM_PIPELINES_KEY | Key with permissions to download terraform modules  | `<SSH_KEY>` |
| ARM_CLIENT_ID           | Azure client id with permissions to deploy resources | `bdca4b9a-ae08-35ea-9c41-51ce9fc9138e` |
| ARM_CLIENT_SECRET       | Azure client secret with permissions to deploy resources | `~Z-kH5i0UqCMFJe4i2WhPX~rg` |
| ARM_TENANT_ID           | Azure Tenant id       | `d12c4d1e-741c-425d-9b23-aec936067bda` |
| APPROVAL_REQUIRED       | *(OPTIONAL)* Configure it to force manual approval on pipelines. Defaults to `false` | `true` |

#### Automated execution - Considerations

* Due to limitations in current Gitlab version, merge requests pipelines are executed against the code in the affected source branch. Other changes added to master via other merge requests or performed manually in the cloud (not recommended!) might not be visible when executing the plan in the merge request pipeline. You can overcome this by performing the following actions:

* Make sure to perform a `git rebase` locally and re-submit de changes prior to perform a merge.
* Use automation *with manual approval* when possible. This will generate an up to date plan that you can review prior to applying the changes.

#### Automated execution - How it works

##### On merge request creation

When a Merge Request is created for the updated code, a pipeline is automatically triggered. This will go through the following *stages*:

* **Format**: Terraform code will be checked to confirm it is properly formatted. In case of issues, you can fix the code by executing `make tf-fmt` as explained in [Code formating](#code-formating).
* **Init-landing-level*/Init-landing**: Initialize and download any required modules/providers.
* **Validate-landing-level*/Validate-landing**: Validate the code to confirm if there are any errors.
* **Plan-landing-level*/Plan-landing**: Execute a plan to see what changes would be performed.

> The difference between `<STAGE>` and `<STAGE>-level*` stages resides on the order of execution. `<STAGE>-level*` stages are always executed prior to `<STAGE>` stages in numeric order.

##### On merge to master (without manual approval)

Once the code is merged to master, a pipeline will be automatically triggered. It will go through the following *stages*:

* **Format**: Terraform code will be checked to confirm it is properly formatted. In case of issues, you can fix the code by executing `make tf-fmt` as explained in [Code formating](#code-formating).
* **Init-landing-level*/Init-landing**: Initialize and download any required modules/providers.
* **Apply-landing-level*/Apply-landing**: Apply all changes into the environment.
* **Output-landing-level*/Output-landing**: Display all outputs returned by the different resources created.

> The difference between `<STAGE>` and `<STAGE>-level*` stages resides on the order of execution. `<STAGE>-level*` stages are always executed prior to `<STAGE>` stages in numeric order.

##### On merge to master (with manual approval)

Once the code is merged to master, a pipeline will be automatically triggered. It will go through the following *stages*:

* **Format**: Terraform code will be checked to confirm it is properly formatted. In case of issues, you can fix the code by executing `make tf-fmt` as explained in [Code formating](#code-formating).
* **Init-landing-level*/Init-landing**: Initialize and download any required modules/providers.
* **Plan-landing-level*/Plan-landing**: Execute a plan to see what changes would be performed.
> Note: There are situations in which a plan might fail because of dependencies between resources (for instance, when creating a landing for first time) but apply would actually work and fix these. Because of this, plan failures will be always marked with a warning but they will still allow you to apply. Make sure to review the plan failure reason before proceeding with the apply. 
* **Apply-landing-level*/Apply-landing**: Apply all changes into the environment. This step requires approval. You need to click on the play *>* button to proceed, once you have verified all changes reported in the *plan* stage are corrected.
* **Output-landing-level*/Output-landing**: Display all outputs returned by the different resources created.

> The difference between `<STAGE>` and `<STAGE>-level*` stages resides on the order of execution. `<STAGE>-level*` stages are always executed prior to `<STAGE>` stages in numeric order.

#### Manually executing a pipeline

It is possible to manually execute a pipeline to apply changes. It will then apply the changes as described on the corresponding *On merge to master* section.

#### Modifying directories to be executed

All directories to be applied are stored in a file called `.gitlab-ci.env.yml`. For instance:

```yaml
---

include:
  - terraform/landing-csz/rg-transit_gateway/.gitlab-ci.jobs.yml
  - terraform/landing-csz/rg-csz/.gitlab-ci.jobs.yml
  - terraform/landing-psz/rg-psz/.gitlab-ci.jobs.yml
  - packer/.gitlab-ci.jobs.yml
```

You can prevent a directory from being executed by commenting or removing the affected line. This is required, for instance, if your environment does not have a PSZ.

> Note: Directories for new *Customer Work Zones* will be added automatically when creating the zone.

#### Destroying a landing/resource group

Currently there's no pipeline to destroy landing or resource group. Manual execution is required as described in section [Manual execution](#manual-execution)

#### Disabling automated execution

Automated execution is enabled by default. You can disable automated execution by renaming the file `.gitlab-ci.yml` to `.gitlab-ci.yml.disabled`.


### Manual execution

This section describes how to execute the deployment of resources locally (without automated pipelines).

#### Order of operations

Landings need to be deployed in the following order:

* landing-csz/rg-virtual_wan *(only required if Virtual Wan is used)*
* landing-csz/rg-csz
* others (psz, cwz...)

#### Make targets

The directory structure enables automatic generation of make targets. You can execute
make from either the top-level `terraform` directory, or from within each landing
directory. **Currently, direct execution of Terraform from the deployment directories
is not supported**.

Make targets are built from three components:

* **Terraform operation**: `apply`, `plan`, `validate`, `destroy`, `output`.
* **Landing zone name**: Directory name stripping the `landing-` prefix (e.g.: `csz`
 for `landing-csz`).
* **Resource Group name**: Directory name within the landing directory (e.g.:
   `rg-csz` for `landing-csz/rg-csz`).

From the `terraform` top level directory, you would do the following to deploy the
main CSZ resource group:

```sh
make tf-apply-csz-rg-csz
```

Alternatively, from inside the landing zone directories, we can call the same targets, but the
generated targets will not have the landing zone component. For example:

```sh
cd terraform/landing-csz
make apply-rg-csz
```

Remember that you can use tab completion to view the available targets.

Ideally, you would execute the normal flow in order:

* `init` (only once, to initialise backends and needed plugins)
* `validate`
* `plan`
* `apply`

Additionally you can use `output` to redisplay state outputs quickly.