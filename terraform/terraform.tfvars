
### This file contains the variable definitions for the Terraform configuration. Each variable has a description and a type, and values are assigned here. The variables are used to parameterize the Terraform code, allowing for flexibility and reusability.###

region = "ap-south-2"
vpc_cidr = "10.0.0.0/16"
public_subnet_1_cidr = "10.0.1.0/24"
public_subnet_2_cidr = "10.0.2.0/24"
private_subnet_1_cidr = "10.0.3.0/24"
private_subnet_2_cidr = "10.0.4.0/24"
cluster_name = "demo-eks-cluster"
node_instance_type = "t3.medium"
desired_size = 2
