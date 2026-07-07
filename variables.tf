variable "project_name" {
  description = "Project name"
  type        = string
  default     = "terraweek"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ingress_ports" {
  description = "Allowed ingress ports"
  type        = list(number)
  default     = [22, 80]
}
