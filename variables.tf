variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "iam_user_name" {
  description = "IAM user ka naam"
  type        = string
  default     = "LAW-user"
}

variable "iam_group_name" {
  description = "IAM group ka naam"
  type        = string
  default     = "LAW-group"
}

variable "iam_role_name" {
  description = "IAM role ka naam"
  type        = string
  default     = "LAW-role"
}