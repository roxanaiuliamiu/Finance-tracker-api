# -----------------------------------------
# Terraform Outputs
# -----------------------------------------

output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.app_alb.dns_name
}

output "alb_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.app_alb.arn
}

output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.postgres.endpoint
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.this.name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.app.name
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = "123456789.dkr.ecr.eu-central-1.amazonaws.com/finance-tracker-api"
}

output "api_endpoint" {
  description = "API endpoint URL"
  value       = "http://${aws_lb.app_alb.dns_name}"
}
