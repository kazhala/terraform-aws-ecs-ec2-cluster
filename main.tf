terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

data "aws_iam_policy_document" "ecs_agent" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_agent" {
  name_prefix        = "${var.cluster_name}-ecs-cluster-agent-"
  assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
}

resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_agent" {
  name = "${var.cluster_name}-ecs-cluster-agent-"
  role = aws_iam_role.ecs_agent.name
}

data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended"
}

resource "aws_launch_configuration" "ecs_launch_config" {
  image_id             = jsondecode(data.aws_ssm_parameter.ecs_ami.value).image_id
  name_prefix          = "${var.cluster_name}-launch-config-"
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  security_groups      = var.security_groups
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config"
  instance_type        = var.instance_type
}

resource "aws_autoscaling_group" "ecs_asg" {
  name_prefix               = "${var.cluster_name}-ecs-cluster-asg-"
  vpc_zone_identifier       = var.subnets
  launch_configuration      = aws_launch_configuration.ecs_launch_config.name
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_type         = var.health_check_type
  target_group_arns         = var.target_group_arns != [] ? var.target_group_arns : null
  load_balancers            = var.load_balancers != [] ? var.load_balancers : null
  health_check_grace_period = var.health_check_grace_period

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-ecs-cluster"
    propagate_at_launch = true
  }
}

resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}
