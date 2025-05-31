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
    replicas = var.replica_count

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
        service_account_name = kubernetes_service_account_v1.service_account.metadata[0].name
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

resource "kubernetes_service_v1" "service" {
  metadata {
    name      = var.application_name
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  spec {
    selector = {
      app = var.application_name
    }
    port {
      port        = var.port
      target_port = var.port
    }

    #I am using  NodePort for simplicity, but in a production environment, you might want to use LoadBalancer or an Ingress
    type = "NodePort"
  }
  
}

resource "kubernetes_service_account_v1" "service_account" {
  metadata {
    name      = var.application_name
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
  
}