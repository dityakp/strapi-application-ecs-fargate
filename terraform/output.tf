output "ecr_repository_url" {
  value = aws_ecr_repository.strapi.repository_url
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.strapi.name
}

output "ecs_service_name" {
  value = aws_ecs_service.strapi.name
}

output "rds_endpoint" {
  value = aws_db_instance.strapi.address
}

output "deployed_image" {
  value = var.image_uri
}

output "ecs_service_info" {
  value = "ECS service deployed - check ECS console for task public IPs"
}

output "alb_dns_name" {
  value = aws_lb.strapi.dns_name
}