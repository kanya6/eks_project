output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subnet_ids"  {
  value = module.module.vpc.public_subnets
}

output "security_group_id" {
  value = module.sg.security_group_id
}