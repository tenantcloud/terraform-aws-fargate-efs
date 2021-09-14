locals {
  cluster_name = replace(var.domain_name, ".", "-")
}