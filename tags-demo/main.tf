
variable tags {
    type = object({
        tag1 = string
        tag2 = string
        tag3 = string
    })
}

locals {
  my_tags = merge(var.tags, {Automation = "Terraform"})
}

resource "null_resource" "test" {
    triggers =  {
        currentdate = timestamp()
    }
}

output "tags" {
    value = local.my_tags
}
