terraform {
  backend "s3" {
    bucket = "eks-kanykei-project"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}