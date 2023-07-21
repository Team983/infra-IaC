module "subnet" {
  source = "../modules/commons/subnet_with_two_zones"

  vpc_id   = module.vpc.id
  vpc_name = module.vpc.name
  igw_id   = module.vpc.internet_gateway_id

  public_subnets = [
    { cidr_block = "10.128.1.0/24", availability_zone = "ap-northeast-2a" },
    { cidr_block = "10.128.2.0/24", availability_zone = "ap-northeast-2c" }
  ]

  private_subnets = [
    { cidr_block = "10.128.100.0/24", availability_zone = "ap-northeast-2a" },
    { cidr_block = "10.128.101.0/24", availability_zone = "ap-northeast-2c" }
  ]

  database_subnets = [
    { cidr_block = "10.128.64.0/24", availability_zone = "ap-northeast-2a" },
    { cidr_block = "10.128.192.0/24", availability_zone = "ap-northeast-2c" },
  ]
}