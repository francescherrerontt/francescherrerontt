
/* List of virtual hubs to deploy.

For instance:

```
virtual_hubs = {
  vhub_01 = {
    location       = "westeurope"
    address_prefix = "10.70.0.0/24"
    sku            = "Standard"
  }
  vhub_02 = {
    location       = "northeurope"
    address_prefix = "10.71.0.0/24"
    sku            = "Standard"
  }
}
```
*/

virtual_hubs = {}

/* Route tables to create
 --------------------------
 `virtual_hub_id` references the id of the virtual hub. You can simply reference it's
 name and terraform code will convert it into its full id

 `next_hop_id` references a resource id (ie. a vnet, azurefw, etc.)
 For azure fw in a vhub, you can simply reference it's name and terraform code
 will convert it into its full id

 IMPORTANT: If this is the first time you deploy your code and you are creating routes
 pointing to vnets or other services (different than azure fw), those might not exist
 yet and routes will fail to deploy. In such an event, comment the problematic routes,
 deploy all missing resources, uncomment the routes and reapply the configuration.

For instance:

```
route_tables = {
  rt-vwan-vhub_01-default = {
    virtual_hub_id = "vhub_01"
    labels    = ["vhub01"]
    routes = {
      inet = {
        destinations = ["0.0.0.0/0"]
        destinations_type = "CIDR"
        next_hop_id = "fw-vhub_01"
      }
    }
  }
}
```
*/

route_tables = {}