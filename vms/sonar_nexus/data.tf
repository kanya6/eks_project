
data "aws_availability_zones" "azs" {}

data "terraform_remote_state" "vpc-sg" {
  backend = "s3"

  config = {
    bucket = "eks-kanykei-project"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}