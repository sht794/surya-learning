variable environment {
  description = "The environment for the VPC (e.g., dev, staging, prod)"
  type        = string
}

variable project_name {
  description = "The name of the project for which the VPC is being created"
  type        = string
}

variable vpc_cidr {
  description = "The CIDR block for the VPC"
  type        = string
}

variable aws_region {
  description = "The AWS region where the VPC will be created"
  type        = string
  default     = "ap-south-1"
}