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
  name_prefix        = "ecs-agent-${var.cluster_name}-"
  assume_role_policy = data.aws_iam_policy_document.ecs_agent.json

  tags = merge(
    {
      Name = "ecs-${var.cluster_name}"
    },
    var.additional_tags
  )
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

resource "aws_launch_configuration" "ecs_launch_config" {
  name_prefix = "${var.cluster_name}-"

  instance_type        = var.instance_type
  image_id             = var.image_id == null ? jsondecode(data.aws_ssm_parameter.ecs_ami.value).image_id : var.image_id
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  security_groups      = var.security_groups

  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
${var.additional_user_data}
EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs_asg" {
  name_prefix = "ecs-${var.cluster_name}-"

  vpc_zone_identifier  = var.subnets
  launch_configuration = aws_launch_configuration.ecs_launch_config.name

  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity

  target_group_arns = var.target_group_arns
  load_balancers    = var.load_balancers

  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  tag {
    key                 = "Name"
    value               = "ecs-${var.cluster_name}"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.additional_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_cluster" "main" {
  name = var.cluster_name

  tags = merge(
    {
      "Name" = "${var.cluster_name}"
    },
    var.additional_tags
  )

  lifecycle {
    create_before_destroy = true
  }
}
