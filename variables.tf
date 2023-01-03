variable "vpc_base_cidr" {
  description = "The base of the address range to be used by the VPC and corresponding Subnets"
  type        = string
}

variable "env_prefix" {
  description = "A prefix which is useful for tagging and naming"
  type        = string
}

variable "env_name" {
  description = "A prefix which is useful for tagging and naming"
  type        = string
}

variable "region" {
  description = "The region in which the environment will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "A list containing 3 AZs"
  type        = list(string)
}

variable "instance_qty" {
  description = "The number of neo4j instances to be deployed"
}

variable "instance_type" {
  description = "The type of EC2 instances to be deployed"
}


variable "public_key_path" {
  description = "The location of the public SSH key within the local environment"
}

variable "private_key_path" {
  description = "The location of the private SSH key within the local environment"
}

/*
variable "private_subnet_qty" {
  description = "The number of private subnets to be deployed"
}
*/