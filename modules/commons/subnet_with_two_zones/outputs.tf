output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}

output "public_subnet_cidr_blocks" {
  value = aws_subnet.public.*.cidr_block
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "private_subnet_cidr_blocks" {
  value = aws_subnet.private.*.cidr_block
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.nat_gateway.*.id
}

output "nat_gateway_eips" {
  value = aws_eip.public.*.public_ip
}
