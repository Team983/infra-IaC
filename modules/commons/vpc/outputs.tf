output "id" {
  value = aws_vpc.this.id
}

output "name" {
  value = var.name
}

output "cidr" {
  value = var.cidr_block
}

output "internet_gateway_id" {
  value = aws_internet_gateway.default.id
}

output "security_group__default_id" {
  value = aws_default_security_group.default.id
}
