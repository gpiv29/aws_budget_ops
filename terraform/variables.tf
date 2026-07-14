
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

variable "environment" {
  description = "Environment (dev, prod)"
  type        = string
  default     = "prod"
}