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

variable "graph_database_version" {
  description = "The Version of the Neo4j Graph Database to be installed"
}

variable "graph_data_science_license_key" {
  description = "License Key for Graph Data Science"
}

variable "install_bloom" {
  description = "Variable to determine if Neo4j Bloom will be installed"
}

variable "bloom_license_key" {
  description = "License Key for Bloom"
}

variable "neo4j_password" {
  description = "DB Password for the Neo4j User"
}




/*
variable "private_subnet_qty" {
  description = "The number of private subnets to be deployed"
}
*/