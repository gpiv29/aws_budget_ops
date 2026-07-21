
variable "s3_bucket_id" {
  type        = string
  default     = "gpiv29-aws-sample-bucket"
  description = "The ID or name of the target S3 bucket."
}

variable "s3_directory_key" {
  type        = string
  default     = "folder1/"
  description = "The folder path/key for the S3 object. Must end with a forward slash."
}

variable "s3_terraform_state_bucket_id" {
  type        = string
  default     = "gpiv29-sample-terraform"
  description = "The ID of the terraform plan state file bucket"
}

variable "region" {
  description = "aws region"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Environment (dev, prod)"
  type        = string
  default     = "prod"
}

variable "tfplan" {
  description = "terraform plan state file name"
  type        = string
  default     = "tfplan"
}