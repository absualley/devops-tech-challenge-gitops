#######################################
# Amazon EKS Cluster
#######################################

resource "aws_eks_cluster" "main" {

  name     = "${var.project_name}-cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  version = "1.33"

  vpc_config {

    subnet_ids = [
      aws_subnet.public_a.id,
      aws_subnet.public_b.id,
      aws_subnet.private_a.id,
      aws_subnet.private_b.id
    ]

    endpoint_private_access = true
    endpoint_public_access  = true

  }

  depends_on = [

    aws_iam_role_policy_attachment.eks_cluster_policy

  ]

  tags = local.common_tags

}

#######################################
# Managed Node Group
#######################################

resource "aws_eks_node_group" "main" {

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-nodes"

  node_role_arn = aws_iam_role.eks_nodes.arn

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  scaling_config {

    desired_size = 2
    min_size     = 2
    max_size     = 3

  }

  instance_types = ["t3.medium"]

  ami_type = "AL2023_x86_64_STANDARD"

  depends_on = [

    aws_iam_role_policy_attachment.worker_node,
    aws_iam_role_policy_attachment.cni,
    aws_iam_role_policy_attachment.ecr_read

  ]

  tags = local.common_tags

}


