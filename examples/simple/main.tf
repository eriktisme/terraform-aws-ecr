locals {
  untagged_image_rule = [{
    rulePriority = 1
    description  = "Remove untagged images."
    selection = {
      tagStatus   = "untagged"
      countType   = "imageCountMoreThan"
      countNumber = 10
    }
    action = {
      type = "expire"
    }
  }]

  remove_old_image_rule = [{
    rulePriority = 2
    description  = "Rotate images when reach 10 images stored.",
    selection = {
      tagStatus   = "any"
      countType   = "imageCountMoreThan"
      countNumber = 10
    }
    action = {
      type = "expire"
    }
  }]
}

module "ecr" {
  source = "../../"

  name = "hello-world"

  lifecycle_policy = jsonencode({
    rules = concat(local.untagged_image_rule, local.remove_old_image_rule)
  })
}
