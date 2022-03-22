
# add Provisioner to tags
locals {
  my_tags = merge(var.tags, {Provisioner = "Terraform"})
}

# trigger a plan
resource "null_resource" "test" {
    triggers =  {
        currentdate = timestamp()
    }
}

# make tags available as output
output "tags" {
    value = local.my_tags
}
