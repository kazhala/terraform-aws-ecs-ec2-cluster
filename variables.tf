variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to deploy this ECS cluster."
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet ids to deploy the ECS cluster. This should be public subnet or equivalent as the ECS agent require internet access."
}

variable "cluster_name" {
  type        = string
  description = "Name of the ECS cluster."
}

variable "security_groups" {
  default     = null
  type        = list(string)
  description = "List of Security Group arns to attach to the ECS cluster EC2 instance."
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "ECS cluster EC2 instance type."
}

variable "additional_user_data" {
  default     = ""
  type        = string
  description = "Additional user data to apply to the ECS instance Launch Configuration."
}

variable "image_id" {
  default     = null
  type        = string
  description = "ECS instance image id. If not provided, the latest Linux Amazon ECS-optimized AMI will be used."
}

variable "max_size" {
  default     = 1
  type        = number
  description = "Maximum number of instances for the cluster."
}

variable "min_size" {
  default     = 1
  type        = number
  description = "Minimum number of instances for the cluster."
}

variable "desired_capacity" {
  default     = 1
  type        = number
  description = "Desired number of instances for the cluster."
}

variable "health_check_type" {
  default     = "ELB"
  type        = string
  description = "Health checking method, can be either ELB or EC2."
}

variable "load_balancers" {
  default     = null
  type        = list(string)
  description = "List of ELB names to attach to the cluster, for ALB use target_group_arns."
}

variable "target_group_arns" {
  default     = null
  type        = list(string)
  description = "List of Target Groups to attach to the cluster, for ELB use load_balancers."
}

variable "health_check_grace_period" {
  default     = 300
  type        = number
  description = "Grace period between each scaling activity for EC2 instances in the ECS cluster."
}

variable "additional_tags" {
  default     = {}
  description = "Additional resource tags. {key = \"key\", value = \"value\"}"
  type        = map(string)
}
