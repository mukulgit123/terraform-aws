variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"
}

variable "ami-ubuntu" {
    description = "AMIs by region"
    default = "ami-759bc50a"
}

variable "nat" {
  type = "map"
  default = {
  "ami" = "ami-01623d7b"
  "inst_type" = "t2.micro"
  "key_name" = "nat1"
  }
}
variable "vpc" {
   type    = "map"
   default = {
       "tag"         = "drupal-vpc"
       "cidr_block"  = "10.0.0.0/16"
       "subnet_bits" = "4"
       "owner_id"    = "mukul-poc"
       
   }
}

variable "destinationCIDRblock" {
       default = "0.0.0.0/0"
}

variable "azs" {
   type = "map"
   default = {
       "us-east-1"      = "us-east-1a,us-east-1b,us-east-1c"
   }
}

variable "aws_key_name" {
    description = "Key name"
    default = "tf1"
}

variable "aws_vpn_instance" {
    description = "Instance Type for VPN Server"
    default = "t2.micro"
}

variable "drupal_db" {
    description = "DB/Hostname of Drupal"
    default = "drupaldb"
}

variable "drupal_user" {
    description = "DB Username"
    default = "drupal"
}

variable "drupal_pass" {
    description = "Drupal Password"
    default = "xxxxxxxxx"
}

variable "rds_disk_size" {
    description = "Drupal DB disk size"
    default = "20"
}

variable "db_instance_type" {
    description = "Drupal DB instance type"
    default = "db.t2.micro"
}

variable "poc_hosted_zone" {
    description = "Hosted zone for POC"
    default = "poc-internal.digital"
}

variable "self_signed_arn" {
    description = "Certificate ARN to be used with Load Balancer"
    default = "arn:aws:iam::XXXXXXXXXXXXXXXXX:server-certificate/pci-dss-x509"
}

variable "redis_node_type" {
    description = "Node type of Redis Cluster"
    default = "cache.t2.micro"
}

variable "redis_parameter_group" {
    description = "Parameter Group for Redis"
    default = "default.redis4.0"
}
