locals {
  repository_name = replace(var.repository_name, "-", "_")
}

resource "aws_ecr_repository" "ecr_repository" {
  name = local.repository_name

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository_policy" "shared" {
  repository = aws_ecr_repository.ecr_repository.name
  policy     = data.aws_iam_policy_document.ecr_shared_access.json
}

data "aws_iam_policy_document" "ecr_shared_access" {
  statement {
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchDeleteImage"
    ]
    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", values(var.accounts))
    }
  }
}

resource "aws_ecr_lifecycle_policy" "life_policy" {
  repository = aws_ecr_repository.ecr_repository.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 30 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
