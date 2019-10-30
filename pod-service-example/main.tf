data "azurerm_kubernetes_cluster" "main" {
  name                = "${var.cluster_name}"
  resource_group_name = "${var.resource_group_name}"
}

provider "kubernetes" {
  host                   = "${data.azurerm_kubernetes_cluster.main.kube_config.0.host}"
  client_certificate     = "${base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate)}"
}

provider "kubernetes" {}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "${var.namespace}"
  }
}

resource "kubernetes_pod" "web" {
  metadata {
    name = "nginx"

    labels {
      name = "nginx"
    }

    namespace = "${kubernetes_namespace.example.metadata.0.name}"
  }

  spec {
    container {
      image = "nginx:1.7.9"
      name  = "nginx"
    }
  }
}

resource "kubernetes_service" "web" {
  metadata {
    name      = "nginx"
    namespace = "${kubernetes_namespace.example.metadata.0.name}"
  }

  spec {
    selector {
      name = "${kubernetes_pod.web.metadata.0.labels.name}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
