output "aws_iam_role" {
  description = "Outputs of the iam role created."

  value = {
    ecs_agent = aws_iam_role.ecs_agent
  }
}

output "aws_iam_instance_profile" {
  description = "Outputs of the instane profile created."

  value = {
    ecs_agent = aws_iam_instance_profile.ecs_agent
  }
}

output "aws_launch_template" {
  description = "Outputs of the launch template."
  sensitive   = true

  value = {
    ecs = aws_launch_template.ecs
  }
}

output "aws_autoscaling_group" {
  description = "Outputs of the ASG."

  value = {
    ecs = aws_autoscaling_group.ecs
  }
}

output "aws_ecs_cluster" {
  description = "Outputs of the ECS cluster."

  value = {
    this = aws_ecs_cluster.this
  }
}
