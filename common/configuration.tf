terraform {
  required_version = ">= 1.0"

  backend "s3" {
    region  = "ap-northeast-2"
    bucket  = "synnote-tfstate"
    key     = "common/terraform.tfstate"
    encrypt = true
    profile = "youngjun-ryu"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

provider "aws" {
  profile = "youngjun-ryu"
  region  = "ap-northeast-2"
}
