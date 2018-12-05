data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      identifiers = [
        "eks.amazonaws.com",
      ]

      type = "Service"
    }
  }
}

resource "aws_iam_role" "eks" {
  assume_role_policy = "${data.aws_iam_policy_document.eks_assume_role.json}"
  name               = "${var.prefix}-eks-cluster"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.eks.name}"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.eks.name}"
}
