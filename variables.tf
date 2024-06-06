variable "vpc_name" {
  description = "Name of AWS VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR of AWS VPC"
  type        = string
}

variable "subnets" {
  description = "List of AWS subnets"
  type        = any
}

variable "igw" {
  description = "Name of AWS internet gateway"
  type        = string
}

variable "public_rtb" {
  description = "Name of AWS route table"
  type        = string
}

variable "private_rtb" {
  description = "Name of AWS route table"
  type        = string
}

variable "sg_name" {
  description = "List of security group names"
  type        = map(string)
}

variable "inbound_rule" {
  type = any
}

variable "instances" {
  type = any
}

variable "instance_type" {
  description = "Type of AWS instance to deploy"
  type        = string
}

variable "ami_id" {
  description = "ID of amazon machine image"
  type        = string
}

variable "ssh_key_name" {
  description = "Path to public key"
  type        = string
  sensitive   = true
}