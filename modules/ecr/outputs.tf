output "ecr_repositories" {
  value = [for repository in aws_ecr_repository.ecr_repositories: repository.name]
}