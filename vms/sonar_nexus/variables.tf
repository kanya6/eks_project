variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnets" {
  description = "Subnet CIDR"
  type        = list(string)
}


variable "sonar_instance_type" {
  type = string
  description = "instance type for the nexus"
} 
variable "nexus_instance_type" {
  type = string
  description = "instance type for the nexus"
} 