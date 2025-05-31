provider "kubernetes" {
  config_path    = var.kube_config_path
  config_context = var.cluster_name
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.application_name
  }
}

resource "kubernetes_deployment_v1" "deployment" {
  metadata {
    name      = var.application_name
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.application_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.application_name
        }
      }

      spec {
        container {
          name  = var.application_name
          image = var.image_repository

          port {
            container_port = var.port
          }
        }
      }
    }
  }
  
}