output "cluster_id" {
  description = "The EKS Cluster ID."
  value       = "${aws_eks_cluster.main.id}"
}

output "kubeconfig" {
  description = "`kubeconfig` configuration to connect to the cluster using `kubectl`"
  value       = "${data.template_file.kubeconfig.rendered}"
}

output "eks_cluster_arn" {
  description = "The Amazon Resource Name of the cluster"
  value       = "${aws_eks_cluster.main.arn}"
}

output "eks_cluster_certificate_authority_data" {
  description = "The base64 encoded certificate data required to communicate with the cluster"
  value       = "${local.certificate_authority_data}"
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the Kubernetes API server"
  value       = "${aws_eks_cluster.main.endpoint}"
}

output "eks_cluster_version" {
  description = "The Kubernetes server version of the cluster"
  value       = "${aws_eks_cluster.main.version}"
}

output "vpc_id" {
  description = "The ID of the EKS Cluster VPC."
  value       = "${aws_vpc.main.id}"
}
