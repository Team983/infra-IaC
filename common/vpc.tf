module "vpc" {
  source = "../modules/commons/vpc"

  name       = "synnote-vpc"
  cidr_block = "10.128.0.0/16"

  tags = {
    "kubernetes.io/cluster/synote-production" = "shared"
    ManagedBy                                 = "terraform"
  }
}
