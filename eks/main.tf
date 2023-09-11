provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                   = local.name
  cluster_version                = local.version
  cluster_endpoint_public_access = true

  enable_irsa = true

  cluster_addons = {
    coredns = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
    }
    vpc-cni = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id                   = local.vpc_id
  subnet_ids               = local.private_subnets
  control_plane_subnet_ids = local.public_subnets

  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium"]

    tags = {
      Cluster     = "synnote-production"
      Environment = "prod"
      ManagedBy   = "terraform"
    }
  }

  eks_managed_node_groups = {
    worker = {
      desired_size = 2
      max_size     = 3
      min_size     = 1
    }
  }

  tags = {
    Environment = "prod"
    ManagedBy   = "terraform"
  }
}

// 프라이빗 서브넷 태그
resource "aws_ec2_tag" "private_subnet_tag" {
  for_each    = toset(local.private_subnets)
  resource_id = each.value
  key         = "kubernetes.io/role/internal-elb"
  value       = "1"
}

resource "aws_ec2_tag" "private_subnet_cluster_tag" {
  for_each    = toset(local.private_subnets)
  resource_id = each.value
  key         = "kubernetes.io/cluster/${local.name}"
  value       = "owned"
}

// 퍼블릭 서브넷 태그
resource "aws_ec2_tag" "public_subnet_tag" {
  for_each    = toset(local.public_subnets)
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
}
