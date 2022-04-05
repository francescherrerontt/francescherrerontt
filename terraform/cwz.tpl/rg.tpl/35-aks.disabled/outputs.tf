output "aks_id" {
  description = "The id of aks cluster"
  value = tomap({
    for k, v in module.aks_cluster : k => v.aks_id
  })
}
