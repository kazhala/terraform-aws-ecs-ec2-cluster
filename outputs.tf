output "asg_id" {
  description = "The ID of the Auto Scaling Group."
  value       = aws_autoscaling_group.ecs.id
}

output "asg_name" {
  description = "The Name of the Auto Scaling Group."
  value       = aws_autoscaling_group.ecs.name
}

output "asg_arn" {
  description = "The ARN of the Auto Scaling Group."
  value       = aws_autoscaling_group.ecs.arn
}

output "cluster_id" {
  description = "The ID of the ECS cluster."
  value       = aws_ecs_cluster.this.id
}

output "cluster_arn" {
  description = "The ARN of the ECS cluster."
  value       = aws_ecs_cluster.this.arn
}
