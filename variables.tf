## Azure config variables ##
variable "client_id" {}

variable "client_secret" {}

variable location {
  default = "Central US"
}

## Resource group variables ##
variable resource_group_name {}


## AKS kubernetes cluster variables ##
variable cluster_name {
  default = "aks-poc"
}

variable "agent_count" {
  default = 3
}

variable "dns_prefix" {
  default = "akspoc"
}

variable "admin_username" {
    default = "demo"
}
