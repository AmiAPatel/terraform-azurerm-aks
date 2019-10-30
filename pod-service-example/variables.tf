## Resource group variables ##
variable resource_group_name {}

## AKS kubernetes cluster variables ##
variable cluster_name {
  default = "aks-poc"
}

variable "namespace" {
  default = "aks-demo"
}
