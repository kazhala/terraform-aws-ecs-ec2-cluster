# terraform-aws-ecs-ec2-cluster

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.63.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_iam_instance_profile.ecs_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ecs_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_iam_policy_document.ecs_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_ssm_parameter.ecs_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_user_data"></a> [additional\_user\_data](#input\_additional\_user\_data) | Additional user data to apply to the ECS instance Launch Configuration. | `string` | `""` | no |
| <a name="input_container_insights"></a> [container\_insights](#input\_container\_insights) | Enable ECS container insights. Allowed values: enabled \| disabled. | `string` | `"enabled"` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Desired number of instances for the cluster. | `number` | `1` | no |
| <a name="input_health_check_grace_period"></a> [health\_check\_grace\_period](#input\_health\_check\_grace\_period) | Grace period between each scaling activity for EC2 instances in the ECS cluster. | `number` | `300` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | Health checking method. Allowed values: ELB \| EC2. | `string` | `"EC2"` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | ECS instance image id. If not provided, the latest Linux Amazon ECS-optimized AMI will be used. | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The EC2 instance type to launch for the ECS cluster. | `string` | `"t3.micro"` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | List of ELB names to attach to the cluster, for ALB use target\_group\_arns. | `list(string)` | `null` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximum number of instances for the cluster. | `number` | `1` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum number of instances for the cluster. | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | The Name of the ECS cluster. | `string` | n/a | yes |
| <a name="input_root_volume_device_name"></a> [root\_volume\_device\_name](#input\_root\_volume\_device\_name) | Name of the root device. /dev/sda1 for normal linux and /dev/xvda for amazon linux. | `string` | `"/dev/xvda"` | no |
| <a name="input_root_volume_encrypted"></a> [root\_volume\_encrypted](#input\_root\_volume\_encrypted) | Encrypt EC2 instance ebs volume. | `bool` | `true` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Size of the root volume. | `number` | `30` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnet ids to deploy the ECS cluster.<br>Subnets should have outbound internet access as the ECS agent require internet access. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional resource tags to apply to applicable resources. Format: {"key" = "value"} | `map(string)` | `{}` | no |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | List of Target Groups to attach to the cluster, for ELB use load\_balancers. | `list(string)` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC to deploy the ECS cluster. | `string` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of security group to attach the instance. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_autoscaling_group"></a> [aws\_autoscaling\_group](#output\_aws\_autoscaling\_group) | Outputs of the ASG. |
| <a name="output_aws_ecs_cluster"></a> [aws\_ecs\_cluster](#output\_aws\_ecs\_cluster) | Outputs of the ECS cluster. |
| <a name="output_aws_iam_instance_profile"></a> [aws\_iam\_instance\_profile](#output\_aws\_iam\_instance\_profile) | Outputs of the instane profile created. |
| <a name="output_aws_iam_role"></a> [aws\_iam\_role](#output\_aws\_iam\_role) | Outputs of the iam role created. |
| <a name="output_aws_launch_template"></a> [aws\_launch\_template](#output\_aws\_launch\_template) | Outputs of the launch template. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
