provider "aws" {
  region = "us-east-1"  # Example configuration parameter
  # other configuration parameters as needed
}
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # version constraints if necessary
    }
  }
}
