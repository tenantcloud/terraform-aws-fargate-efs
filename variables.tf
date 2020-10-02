variable "access_key" {
  description = "AWS access key"
  type        = string
  default     = ""
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-west-2"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "963713796187.dkr.ecr.us-west-2.amazonaws.com/tenantcloud/www:latest"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = "3"
}

variable "app_count_min" {
  description = "Minimum number of docker containers to run"
  default     = "3"
}

variable "app_count_max" {
  description = "Maximum number of docker containers to run"
  default     = "10"
}


variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "512"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "dns_zone_id" {
  default = "ZOAXSTCXROYYP"
}

variable "certificate_arn" {
  description = "Certificate ARN"
  default     = ""
}

variable "domain_name" {
  default = "promo.tenants.cloud"
}

variable "project" {
  description = "Name of project (Max 10 character without special)"
  default     = "www"
}

variable "vpc_id" {
  default = ""
}

variable "subnets_public" {
  default = ""
}

variable "subnets_private" {
  default = ""
}

variable "file_system_id" {
  default = ""
}

variable "access_point_id" {
  default = ""
}