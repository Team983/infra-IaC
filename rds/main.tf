module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.name

  engine               = var.engine
  engine_version       = var.engine_version
  family               = var.family               // DB parameter group
  major_engine_version = var.major_engine_version // DB option group
  instance_class       = var.instance_class

  allocated_storage     = 10
  max_allocated_storage = 20

  db_name  = local.db_name
  username = local.username
  password = local.password
  port     = local.port

  multi_az               = true
  vpc_security_group_ids = [aws_security_group.this.id] // RDS Instance에 대한 SG
  db_subnet_group_name   = local.db_subnet_group_name   // DB Subnet Group

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  deletion_protection = true // Database Deletion Protection

  enabled_cloudwatch_logs_exports = ["slowquery"]

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    },
    {
      name = "general_log"
      value = 1
    },
    {
      name = "log_output"
      value = "FILE"
    },
    {
      name = "long_query_time"
      value = 2
    },
    {
      name = "slow_query_log"
      value = 1
    },
    {
      name = "time_zone"
      value = "Asia/Seoul"
    }
  ]

  tags = merge({
    Name      = var.name
    ManagedBy = "terraform"
  }, var.tags)
}


resource "aws_security_group" "this" {
  vpc_id = local.vpc_id
  name   = "${local.vpc_name}-rds-${var.name}"

  dynamic "ingress" {
    for_each = local.allow_security_groups
    content {
      from_port       = 3306
      to_port         = 3306
      protocol        = "TCP"
      security_groups = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name      = "synnote-vpc-rds-common"
    ManagedBy = "terraform"
  })
}