terraform {
  backend "s3" {
    bucket = "eks-kanykei-project"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}