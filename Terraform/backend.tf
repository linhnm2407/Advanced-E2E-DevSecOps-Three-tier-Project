terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.18.0"
    }
  }
  required_version = ">=0.13.0"
  backend "s3" {
    bucket         = "advanced-end-to-end-devsecops-100"
    key            = "state/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "terraform-state-locking"
  }
}
