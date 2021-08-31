project = "k8s-ingress"

variable "namespace" {
  default     = "projectcontour"
  type        = string
  description = "The namespace to deploy and release to in your Kubernetes cluster."
}

app "one" {
  labels = {
    "service" = "one",
    "env"     = "dev"
  }

  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "localhost:5000/one"
        tag   = "1"
        local = false
      }
    }
  }

  deploy {
    use "kubernetes" {
      probe_path = "/"
      namespace  = var.namespace
    }
  }

  release {
    use "kubernetes" {
      load_balancer = true
      port          = 3000

      namespace = var.namespace
    }
  }

}


app "two" {
  labels = {
    "service" = "two",
    "env"     = "dev"
  }

  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "localhost:5000/two"
        tag   = "1"
        local = false
      }
    }
  }

  deploy {
    use "kubernetes" {
      probe_path = "/"
      namespace  = var.namespace
    }
  }

  release {
    use "kubernetes" {
      load_balancer = true
      port          = 4000

      namespace = var.namespace
    }
  }
}
