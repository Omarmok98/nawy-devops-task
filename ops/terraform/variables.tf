variable "cluster_name" {
  type        = string
  description = "The Kuberentes Cluster Name"
  default = "minikube"
}

variable "kube_config_path" {
  type        = string
  description = "The path to the kube config file"
  default     = "~/.kube/config"
}

variable "application_name" {
  type        = string
  description = "The name of the application to be deployed"
  default     = "node-hello"
  
}

variable "replica_count" {
  type        = number
  description = "The number of replicas for the deployment"
  default     = 1
  
}

#Ideally the repsoitory value should be a secret, but for simplicity we are specifying it directly.
variable "image_repository" {
  type        = string
  description = "The Docker image repository for the application"
  default     = "omarmok/node-hello:latest"
}

variable "port" {
  type        = number
  description = "The port on which the application will run"
  default     = 3000
}