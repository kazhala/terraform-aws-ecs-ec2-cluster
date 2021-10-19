variable "vpc_id" {
  description = "The ID of the VPC to deploy the ECS cluster."
  type        = string
}

variable "subnets" {
  description = <<EOF
List of subnet ids to deploy the ECS cluster.
Subnets should have outbound internet access as the ECS agent require internet access.
EOF

  type = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of security group to attach the instance."
  type        = list(string)
  default     = []
}

variable "name" {
  description = "The Name of the ECS cluster."
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type to launch for the ECS cluster."
  type        = string
  default     = "t3.micro"
}

variable "root_volume_encrypted" {
  description = "Encrypt EC2 instance ebs volume."
  type        = bool
  default     = true
}

variable "root_volume_size" {
  description = "Size of the root volume."
  type        = number
  default     = 30
}

variable "root_volume_device_name" {
  description = "Name of the root device. /dev/sda1 for normal linux and /dev/xvda for amazon linux."
  type        = string
  default     = "/dev/xvda"
}

variable "container_insights" {
  description = "Enable ECS container insights. Allowed values: enabled | disabled."
  type        = string
  default     = "enabled"
}

variable "additional_user_data" {
  description = "Additional user data to apply to the ECS instance Launch Configuration."
  type        = string
  default     = ""
}

variable "image_id" {
  description = "ECS instance image id. If not provided, the latest Linux Amazon ECS-optimized AMI will be used."
  type        = string
  default     = null
}

variable "max_size" {
  description = "Maximum number of instances for the cluster."
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum number of instances for the cluster."
  type        = number
  default     = 1
}

variable "desired_capacity" {
  description = "Desired number of instances for the cluster."
  type        = number
  default     = 1
}

variable "health_check_type" {
  description = "Health checking method. Allowed values: ELB | EC2."
  type        = string
  default     = "EC2"
}

variable "load_balancers" {
  description = "List of ELB names to attach to the cluster, for ALB use target_group_arns."
  type        = list(string)
  default     = null
}

variable "target_group_arns" {
  description = "List of Target Groups to attach to the cluster, for ELB use load_balancers."
  type        = list(string)
  default     = null
}

variable "health_check_grace_period" {
  description = "Grace period between each scaling activity for EC2 instances in the ECS cluster."
  type        = number
  default     = 300
}

variable "tags" {
  description = "Additional resource tags to apply to applicable resources. Format: {\"key\" = \"value\"}"
  type        = map(string)
  default     = {}
}
