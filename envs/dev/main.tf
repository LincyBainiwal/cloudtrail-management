terraform {
  required_version = ">= 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "cloudtrail_auditor" {
  source = "./modules/cloudtrail"

  trail_name  = "lincy-management-audit-trail"
  # bucket_name = "lincy-cloudtrail-audit-bucket-12345"
  bucket_name = "lincy-cloudtrail-audit-bucket-vcs-dev-12345"

  tags = {
    Name        = "cloudtrail-management"
    Environment = "Dev"
  }
}