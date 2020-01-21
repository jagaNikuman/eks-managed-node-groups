

resource "aws_eks_cluster" "test-cluster" {
    name     = "test-cluster"
    role_arn = "${aws_iam_role.eks-test-cluster-role.arn}"

    version  = "1.14"

    vpc_config {
        subnet_ids = ["${aws_subnet.eks-test-cluster-subnet.*.id}"]
        endpoint_public_access = true
    }
}

output "api_endpoint" {
    value = "${aws_eks_cluster.test-cluster.endpoint}"
}
output "kubeconfig-certificate-authority-data" {
    value = "${aws_eks_cluster.test-cluster.certificate_authority.0.data}"
}

resource "aws_eks_node_group" "test-cluster-node-group" {
    cluster_name    = "${aws_eks_cluster.test-cluster.name}"
    node_group_name = "test-cluster-node-group"
    node_role_arn   = "${aws_iam_role.eks-test-cluster-node-role.arn}"
    subnet_ids      = ["${aws_subnet.eks-test-cluster-subnet.*.id}"]

    scaling_config {
        desired_size = 3
        max_size     = 3
        min_size     = 3
    }
}
