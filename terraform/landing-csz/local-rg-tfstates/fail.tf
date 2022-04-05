data "external" "throw_error" {
  count   = 1
  program = ["bash", "-c", ">&2 echo 'Please review all tfvars files in all modules, and then delete ${path.module}/fail.tf';exit 1"]
}
