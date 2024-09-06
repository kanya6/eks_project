#EC2

module "sonar-server" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "Jenkins-Server"
  ami = "ami-0e86e20dae9224db8"
  instance_type               = var.sonar_instance_type
  key_name                    = "eks-terraform-key"
  monitoring                  = true
  vpc_security_group_ids      = [ data.terraform_remote_state.vpc-sg.outputs.security_group_id ]
  subnet_id                   = data.terraform_remote_state.vpc-sg.outputs.public_subnet_ids[0]
  associate_public_ip_address = true
  user_data                   = file("sonar-install.sh")
  availability_zone           = data.aws_availability_zones.azs.names[0]

  tags = {
    Name        = "sonar-server"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "nexus-server" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "nexus-Server"
  ami = "ami-0e86e20dae9224db8"
  instance_type               = var.nexus_instance_type
  key_name                    = "eks-terraform-key"
  monitoring                  = true
  vpc_security_group_ids      = [ data.terraform_remote_state.vpc-sg.outputs.security_group_id ]
  subnet_id                   = data.terraform_remote_state.vpc-sg.outputs.public_subnet_ids[0]
  associate_public_ip_address = true
  user_data                   = file("nexus-install.sh")
  availability_zone           = data.aws_availability_zones.azs.names[0]

  tags = {
    Name        = "nexus-server"
    Terraform   = "true"
    Environment = "dev"
  }
}