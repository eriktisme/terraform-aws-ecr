output "name" {
  description = "The name of the repository."
  value       = aws_ecr_repository.this.name
}

output "arn" {
  description = "The ARN of the repository."
  value       = aws_ecr_repository.this.arn
}

output "url" {
  description = "The url of the repository."
  value       = aws_ecr_repository.this.repository_url
}
