resource "aws_iam_role" "node" {
  name               = "${var.cluster_name}-${var.name}-eks-node"
  assume_role_policy = data.aws_iam_policy_document.node-assume.json
  tags = merge(
    local.tags,
    { Name = "${var.cluster_name}-${var.name}-eks-node" }
  )
}

resource "aws_iam_role_policy_attachment" "node-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "registry-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node.name
}

data "aws_iam_policy_document" "node-assume" {
  statement {
    sid     = "AllowAssume"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}
