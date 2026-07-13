provider "aws" {
  region = "us-east-2"
}

# data "aws_ami" "ubuntu" {
#   most_recent = true
#
#   filter {
#     name = "name"
#     values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
#   }
#
#   owners = ["099720109477"] # Canonical
# }

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_id

  tags = {
    Name        = var.s3_bucket_id
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

# Enable server-side encryption using AWS KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "my_bucket_encryption" {
  bucket = var.s3_bucket_id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
      # Optionally specify your own KMS key
      # kms_master_key_id = aws_kms_key.my_key.arn
    }
    bucket_key_enabled = true
  }
}

# Block all public access - this is critical for security
resource "aws_s3_bucket_public_access_block" "my_bucket_public_access" {
  bucket = var.s3_bucket_id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle rules to save on storage costs
resource "aws_s3_bucket_lifecycle_configuration" "my_bucket_folder_lifecycle" {
  bucket = var.s3_bucket_id

  # Clean up incomplete multipart uploads after 7 days
  rule {
    id     = "abort-incomplete-uploads"
    status = "Enabled"

    filter {
      prefix = var.s3_directory_key
    }

    transition {
      days = 0
      storage_class = "DEEP_ARCHIVE"
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}

# CORS configuration for web applications
resource "aws_s3_bucket_cors_configuration" "my_bucket_cors" {
  bucket = var.s3_bucket_id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["https://myapp.example.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3600
  }
}

# Create directory
resource "aws_s3_object" "my_bucket_folder" {
  bucket       = var.s3_bucket_id
  key          = var.s3_directory_key
  content_type = "application/x-directory"
}