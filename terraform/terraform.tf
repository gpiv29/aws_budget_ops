terraform {
  backend "s3" {
    bucket         = "gpiv29-sample-terraform"
    key            = "tfplan" #object key
    region         = "us-east-2"
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