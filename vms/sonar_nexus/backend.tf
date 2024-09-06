terraform {
  backend "s3" {
    bucket = "eks-kanykei-project"
    key    = "sonar-nexus/terraform.tfstate"
    region = "us-east-1"
  }
}