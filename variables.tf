variable "cluster_name" {
  description = "The name of EKS cluster"
  type        = "string"
}

variable "prefix" {
  description = "Prefix for all the resources created"
  default     = ""
  type        = "string"
}

variable "cidr_block" {
  description = "The CIDR block for the EKS Cluster VPC."
  type        = "string"
}

variable "node_type" {
  default     = "dc2.large"
  description = "The node type to be provisioned for the cluster."
  type        = "string"
}

variable "number_of_nodes" {
  default     = 1
  description = "The number of compute nodes in the cluster."
  type        = "string"
}

variable "publicly_accessible" {
  default     = true
  description = "If true, the cluster can be accessed from a public network."
  type        = "string"
}

variable "role_arns" {
  default     = []
  description = "A list of IAM Role ARNs to associate with the cluster. A Maximum of 10 can be associated to the cluster at any time."
  type        = "list"
}

variable "statement_timeout" {
  default     = 0
  description = "The value to assign to the PostgreSQL statement_timeout parameter."
  type        = "string"
}

variable "whitelist_cidr_blocks" {
  default = [
    "0.0.0.0/0",
  ]

  description = "List of CIDR blocks to whitelist for access to the Cluster."
  type        = "list"
}
