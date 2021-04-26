# terraform-aws-ecs-ec2-cluster

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

| Name                                                   | Version |
| ------------------------------------------------------ | ------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | >= 3.0  |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 3.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                               | Type        |
| -------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_autoscaling_group.ecs_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group)                     | resource    |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster)                                    | resource    |
| [aws_iam_instance_profile.ecs_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile)             | resource    |
| [aws_iam_role.ecs_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                     | resource    |
| [aws_iam_role_policy_attachment.ecs_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource    |
| [aws_launch_configuration.ecs_launch_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration)     | resource    |
| [aws_iam_policy_document.ecs_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)            | data source |
| [aws_ssm_parameter.ecs_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter)                          | data source |

## Inputs

| Name                                                                                                         | Description                                                                                                                        | Type           | Default      | Required |
| ------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------- | -------------- | ------------ | :------: |
| <a name="input_additional_user_data"></a> [additional_user_data](#input_additional_user_data)                | Additional user data to apply to the ECS instance Launch Configuration.                                                            | `string`       | `""`         |    no    |
| <a name="input_desired_capacity"></a> [desired_capacity](#input_desired_capacity)                            | Desired number of instances for the cluster.                                                                                       | `number`       | `1`          |    no    |
| <a name="input_health_check_grace_period"></a> [health_check_grace_period](#input_health_check_grace_period) | Grace period between each scaling activity for EC2 instances in the ECS cluster.                                                   | `number`       | `300`        |    no    |
| <a name="input_health_check_type"></a> [health_check_type](#input_health_check_type)                         | Health checking method, can be either ELB or EC2.                                                                                  | `string`       | `"ELB"`      |    no    |
| <a name="input_image_id"></a> [image_id](#input_image_id)                                                    | ECS instance image id. If not provided, the latest Linux Amazon ECS-optimized AMI will be used.                                    | `string`       | `null`       |    no    |
| <a name="input_instance_type"></a> [instance_type](#input_instance_type)                                     | ECS cluster EC2 instance type.                                                                                                     | `string`       | `"t3.micro"` |    no    |
| <a name="input_load_balancers"></a> [load_balancers](#input_load_balancers)                                  | List of ELB names to attach to the cluster, for ALB use target_group_arns.                                                         | `list(string)` | `null`       |    no    |
| <a name="input_max_size"></a> [max_size](#input_max_size)                                                    | Maximum number of instances for the cluster.                                                                                       | `number`       | `1`          |    no    |
| <a name="input_min_size"></a> [min_size](#input_min_size)                                                    | Minimum number of instances for the cluster.                                                                                       | `number`       | `1`          |    no    |
| <a name="input_name"></a> [name](#input_name)                                                                | Name of the ECS cluster.                                                                                                           | `string`       | n/a          |   yes    |
| <a name="input_security_groups"></a> [security_groups](#input_security_groups)                               | List of Security Group arns to attach to the ECS cluster EC2 instance.                                                             | `list(string)` | `null`       |    no    |
| <a name="input_subnets"></a> [subnets](#input_subnets)                                                       | List of subnet ids to deploy the ECS cluster. This should be public subnet or equivalent as the ECS agent require internet access. | `list(string)` | n/a          |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                | Additional resource tags to apply to applicable resources. Format: {"key" = "value"}                                               | `map(string)`  | `{}`         |    no    |
| <a name="input_target_group_arns"></a> [target_group_arns](#input_target_group_arns)                         | List of Target Groups to attach to the cluster, for ELB use load_balancers.                                                        | `list(string)` | `null`       |    no    |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id)                                                          | The ID of the VPC to deploy this ECS cluster.                                                                                      | `string`       | n/a          |   yes    |

## Outputs

| Name                                                                 | Description              |
| -------------------------------------------------------------------- | ------------------------ |
| <a name="output_asg_arn"></a> [asg_arn](#output_asg_arn)             | Auto Scaling Group arn.  |
| <a name="output_asg_id"></a> [asg_id](#output_asg_id)                | Auto Scaling Group id.   |
| <a name="output_asg_name"></a> [asg_name](#output_asg_name)          | Auto Scaling Group name. |
| <a name="output_cluster_arn"></a> [cluster_arn](#output_cluster_arn) | ECS Cluster arn.         |
| <a name="output_cluster_id"></a> [cluster_id](#output_cluster_id)    | ECS Cluster id.          |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
