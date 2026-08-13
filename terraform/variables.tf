variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "devops-tech-challenge-gitops"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
