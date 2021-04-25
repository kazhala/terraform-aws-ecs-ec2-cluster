output "asg_id" {
  value       = aws_autoscaling_group.ecs_asg.id
  description = "Auto Scaling Group id."
}

output "asg_name" {
  value       = aws_autoscaling_group.ecs_asg.name
  description = "Auto Scaling Group name."
}

output "asg_arn" {
  value       = aws_autoscaling_group.ecs_asg.arn
  description = "Auto Scaling Group arn."
}

output "cluster_id" {
  value       = aws_ecs_cluster.main.id
  description = "ECS Cluster id."
}

output "cluster_arn" {
  value       = aws_ecs_cluster.main.arn
  description = "ECS Cluster arn."
}
