terraform {
  backend "s3" {
    bucket         = var.s3_terraform_state_bucket_id
    key            = var.tfplan #object key
    region         = var.environment
    use_lockfile   = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.15.8"
}