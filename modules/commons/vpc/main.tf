// VPC
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true // 워커노드가 생성되면 DNS 호스트 이름을 받게 설정하여 DNS 통신이 가능
  enable_dns_hostnames = true // 워커노드가 생성되면 DNS 호스트 이름을 받게 설정하여 DNS 통신이 가능
  tags                 = merge(local.vpc_tags, var.tags)
}

// Internet Gateway
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.vpc_tags)
}

// Default DHCP Option Set
resource "aws_default_vpc_dhcp_options" "default" {
  tags = {
    Name = "${var.name}-default"
  }
}

// Default NACL
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.this.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  lifecycle {
    ignore_changes = [subnet_ids]
  }

  tags = {
    Name = "${var.name}-default"
  }
}

// Default Routing Table
resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  tags = {
    Name = "${var.name}-default"
  }
}

// Default Security Group
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.this.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-default"
  }
}

