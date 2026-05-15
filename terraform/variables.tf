
### This file defines the input variables for the Terraform configuration.###

variable "region" {
  description = "AWS Region"
  type = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type = string
}

variable "public_subnet_1_cidr" {
  description = "Public-Subnet-Cidr"
  type = string
}

variable "public_subnet_2_cidr" {
  description = "Public-Subnet-2-Cidr"
  type = string
}

variable "private_subnet_1_cidr" {
  description = "Private-Subnet-1-Cidr"
  type = string
}

variable "private_subnet_2_cidr" {
  description = "Private-Subnet-2-Cidr"
  type = string
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type = string
}

variable "node_instance_type" {
  description = "EC2 Instance Type for Worker Nodes"
  type = string
}

variable "desired_size" {
  description = "Desired Number of Worker Nodes"
  type = number
}