resource "aws_ecr_repository" "this" {
  name                 = var.namespace != "" ? "${var.namespace}/${var.name}" : var.name
  image_tag_mutability = var.mutability

  image_scanning_configuration {
    scan_on_push = var.enable_scan_on_push
  }

  tags = merge(var.tags)
}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  policy     = var.lifecycle_policy
  repository = aws_ecr_repository.this.name
}

data "aws_iam_policy_document" "readonly_access" {
  statement {
    sid    = "ContainerRegistryReadOnlyAccess"
    effect = "Allow"

    principals {
      identifiers = var.allowed_read_principals
      type        = "AWS"
    }

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImageScanFindings",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:ListTagsForResource",
    ]
  }
}

data "aws_iam_policy_document" "write_access" {
  statement {
    sid    = "ContainerRegistryWriteAccess"
    effect = "Allow"

    principals {
      identifiers = var.allowed_write_principals
      type        = "AWS"
    }

    actions = ["ecr:*"]
  }
}

data "aws_iam_policy_document" "access_policies" {
  source_json   = data.aws_iam_policy_document.readonly_access.json
  override_json = data.aws_iam_policy_document.write_access.json
}

resource "aws_ecr_repository_policy" "repository_access_policy" {
  policy     = data.aws_iam_policy_document.access_policies.json
  repository = aws_ecr_repository.this.name
}
