resource "aws_iam_role" "eks-test-cluster-role" {
    name = "eks-test-cluster-role"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-test-cluster-role-AmazonEKSClusterPolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role       = "${aws_iam_role.eks-test-cluster-role.name}"
}

resource "aws_iam_role_policy_attachment" "eks-test-cluster-role-AmazonEKSServicePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
    role       = "${aws_iam_role.eks-test-cluster-role.name}"
}

resource "aws_iam_role" "eks-test-cluster-node-role" {
    name = "eks-test-cluster-node-role"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-test-cluster-node-role-AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = "${aws_iam_role.eks-test-cluster-node-role.name}"
}

resource "aws_iam_role_policy_attachment" "eks-test-cluster-node-role-AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = "${aws_iam_role.eks-test-cluster-node-role.name}"
}

resource "aws_iam_role_policy_attachment" "eks-test-cluster-node-role-AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = "${aws_iam_role.eks-test-cluster-node-role.name}"
}
