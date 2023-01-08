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

variable "target_region" {
  description = "The region in which the environment will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "A list containing 3 AZs"
  type        = list(string)
  default     = ["a", "b", "c"]
}

variable "node_count" {
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

variable "install_gds" {
  description = "Determine if GDS is required"
}

variable "install_bloom" {
  description = "Determine if Bloom is required"
}

variable "gds_key" {
  description = "License Key for Graph Data Science"
}

variable "bloom_key" {
  description = "License Key for Bloom"
}

variable "neo4j_password" {
  description = "Password for the neo4j user"
}

variable "install_apoc" {
  description = "Determine if the APOC library is required"
}

variable "neo4j-ami-list" {
  description = "A map containing the neo4j AMIs"
  type = map(string)
  default = {
    "us-east-1" = "ami-0e400af847eb9a531"
    "eu-west-1" = "ami-0f91decef80d7d93b"
  }
}