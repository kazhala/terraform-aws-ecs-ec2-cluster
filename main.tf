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
  name_prefix        = "ecs-agent-${var.name}-"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json

  tags = merge(
    {
      Name = "ecs-${var.name}"
    },
    var.tags
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

resource "aws_launch_configuration" "ecs" {
  name_prefix = "${var.name}-"

  instance_type        = var.instance_type
  image_id             = var.image_id == null ? jsondecode(data.aws_ssm_parameter.ecs_ami.value).image_id : var.image_id
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  security_groups      = var.security_groups

  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.name} >> /etc/ecs/ecs.config
${var.additional_user_data}
EOF

  root_block_device {
    encrypted = var.encrypted
  }
}

resource "aws_autoscaling_group" "ecs" {
  name_prefix = "ecs-${var.name}-"

  vpc_zone_identifier  = var.subnets
  launch_configuration = aws_launch_configuration.ecs.name

  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity

  target_group_arns = var.target_group_arns
  load_balancers    = var.load_balancers

  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  tag {
    key                 = "Name"
    value               = "ecs-${var.name}"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_ecs_cluster" "this" {
  # checkov:skip=CKV_AWS_65:Optional container insights.
  name = var.name

  setting {
    name  = "containerInsights"
    value = var.container_insights
  }

  tags = merge(
    {
      "Name" = "${var.name}"
    },
    var.tags
  )
}
