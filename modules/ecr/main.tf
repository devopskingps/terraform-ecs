resource "aws_ecr_repository" "ecr_repositories" {
  for_each = var.ecr_repositories

  name                  = "${var.env}-${each.value.name}"
  image_tag_mutability  = each.value.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }
  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name        = "${each.key}"
    Environment = "${var.env}"
  }
}


# resource "aws_ecr_repository_policy" "ecr_repositories_policy" {
#   for_each = var.ecr_repositories
#   repository = aws_ecr_repository.ecr_repositories.name

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Sid = "AllowPull",
#         Effect = "Allow",
#         Principal = "*",
#         Action = [
#           "ecr:GetDownloadUrlForLayer",
#           "ecr:BatchGetImage",
#           "ecr:BatchCheckLayerAvailability"
#         ]
#       }
#     ]
#   })
# }