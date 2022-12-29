variable "region" {
  description = "choose region for your stack"
  type        = string
}

variable "vpcname" {
  type        = string
  description = "Name of the VPC"
}

# variable "name" {
#   type        = string
#   description = "Name of to tag any resource"
# }

variable "vpc_cidr" {
  description = "choose cidr for vpc"
  type        = string
}

variable "publicsubnet1_cidr" {
  description = "choose cidr for vpc"
  type        = string
}

variable "publicsubnet2_cidr" {
  description = "choose cidr for vpc"
  type        = string
}

variable "privatesubnet1_cidr" {
  description = "choose cidr for vpc"
  type        = string
}

variable "privatesubnet2_cidr" {
  description = "choose cidr for vpc"
  type        = string
}

variable "availability_zones-1a" {
  type        = string
  description = " availability zones for public subnet"
}

variable "availability_zones-1b" {
  type        = string
  description = " availability zones for public subnet"
}

variable "project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to the VPC resources"

}

variable "instance_type" {
  type        = string
  description = "to select the instnce type for ec2"
}

variable "instance_type2" {
  type        = string
  description = "to select the instnce type for ec2"
}

variable "ami" {
  type        = string
  description = "to select the instance ami for ec2 "
}

variable "ami2" {
  type        = string
  description = "to select the instance ami for ec2 "
}

variable "key_name" {
  type        = string
  description = "EC2 Key pair name for the bastion"
}