locals {
  tags = merge({ "Name" = "${var.name}" }, var.tags)

  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.name} >>/etc/ecs/ecs.config
${var.additional_user_data}
EOF
}

data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_agent" {
  name_prefix        = "${substr("${var.name}-ecs-agent-", 0, 37)}-"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json

  tags = merge({ Name = "ecs-${var.name}" }, var.tags)
}

resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_agent" {
  name = aws_iam_role.ecs_agent.name
  role = aws_iam_role.ecs_agent.name
}

data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended"
}

resource "aws_launch_template" "ecs" {
  name_prefix = "${var.name}-"

  instance_type          = var.instance_type
  image_id               = var.image_id == null ? jsondecode(data.aws_ssm_parameter.ecs_ami.value).image_id : var.image_id
  user_data              = base64encode(local.user_data)
  vpc_security_group_ids = var.vpc_security_group_ids

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_agent.name
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  block_device_mappings {
    device_name = var.root_volume_device_name

    ebs {
      encrypted             = var.root_volume_encrypted
      delete_on_termination = true
      volume_type           = "gp3"
      volume_size           = var.root_volume_size
    }
  }

  tags = local.tags
}

resource "aws_autoscaling_group" "ecs" {
  name_prefix = "${var.name}-ecs-"

  vpc_zone_identifier = var.subnets

  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity

  target_group_arns = var.target_group_arns
  load_balancers    = var.load_balancers

  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }

  dynamic "tag" {
    for_each = merge({ Name = "ecs-${var.name}" }, var.tags)
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_ecs_cluster" "this" {
  name = var.name

  setting {
    name  = "containerInsights"
    value = var.container_insights
  }

  tags = local.tags
}
