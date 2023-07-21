output "vpc_id" {
  value = module.vpc.id
}

output "vpc_name" {
  value = module.vpc.name
}

output "vpc_cidr" {
  value = module.vpc.cidr
}

output "vpc_igw_id" {
  value = module.vpc.internet_gateway_id
}

output "vpc_sg_default_id" {
  value = module.vpc.security_group__default_id
}

output "public_subnet_ids" {
  value = module.subnet.public_subnet_ids
}

output "public_subnet_cidrs" {
  value = module.subnet.public_subnet_cidr_blocks
}

output "private_subnet_ids" {
  value = module.subnet.private_subnet_ids
}

output "private_subnet_cidrs" {
  value = module.subnet.private_subnet_cidr_blocks
}

output "database_subnet_ids" {
  value = module.subnet.database_subnet_ids
}

output "database_subnet_name" {
  value = module.subnet.database_subnet_name
}

output "database_subnet_cidrs" {
  value = module.subnet.database_subnet_cidr_blocks
}

output "nat_gateway_ids" {
  value = module.subnet.nat_gateway_ids
}

output "nat_gateway_eips" {
  value = module.subnet.nat_gateway_eips
}
