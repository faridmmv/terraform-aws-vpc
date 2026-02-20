variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "my-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "az" {
  description = "Availability zone to deploy the subnet"
  type        = string
}

variable "is_public" {
  description = "If true, create IGW and route table for public access"
  type        = bool
  default     = false
}

variable "my_ip" {
  description = "Your public IP address (e.g., '203.0.113.5/32') for SSH/Wireguard access"
  type        = string
  default     = "0.0.0.0/0" # Warning: Open to world by default
}

variable "tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default = {
    deployed_by = "terraform"
  }
}