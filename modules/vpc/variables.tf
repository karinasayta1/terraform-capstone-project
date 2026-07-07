variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "environment" {
  description = "Workspace/environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}
