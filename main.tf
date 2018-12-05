resource "aws_eks_cluster" "main" {
  name     = "${var.prefix}-${var.cluster_name}"
  role_arn = "${aws_iam_role.eks.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.main.id}"]
    subnet_ids         = ["${aws_subnet.main.*.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.AmazonEKSServicePolicy",
  ]
}

locals {
  certificate_authority_data_list          = "${coalescelist(aws_eks_cluster.main.*.certificate_authority, list(list(map("data", ""))))}"
  certificate_authority_data_list_internal = "${local.certificate_authority_data_list[0]}"
  certificate_authority_data_map           = "${local.certificate_authority_data_list_internal[0]}"
  certificate_authority_data               = "${local.certificate_authority_data_map["data"]}"
}

data "template_file" "kubeconfig" {
  template = "${file("${path.module}/kubeconfig.tpl")}"

  vars {
    server                     = "${join("", aws_eks_cluster.main.*.endpoint)}"
    certificate_authority_data = "${local.certificate_authority_data}"
    cluster_name               = "${aws_eks_cluster.main.id}"
  }
}
