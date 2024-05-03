locals {
  env = lower(terraform.workspace)

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}"
    },
  )
}