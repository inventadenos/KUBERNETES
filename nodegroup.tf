resource "aws_eks_node_group" "prod" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "ufuoma-prod"
  node_role_arn   = aws_iam_role.worker.arn
  capacity_type = "ON_DEMAND"
  disk_size = "20"
  instance_types = ["t2.micro"]
  remote_access {
    ec2_ssh_key = "myk8s"
    source_security_group_ids = [aws_security_group.node.id]
  } 
  
  subnet_ids      = [aws_subnet.pub_sub1.id, aws_subnet.pub_sub2.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_subnet.pub_sub1,
    aws_subnet.pub_sub2,
  ]
}

resource "aws_eks_node_group" "dev" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "ufuoma-dev"
  node_role_arn   = aws_iam_role.worker.arn
  subnet_ids      = [aws_subnet.pub_sub1.id, aws_subnet.pub_sub2.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}