project = "example-go-multiapp-k8s-ingress"

variable "namespace" {
  default     = "ingress-nginx"
  type        = string
  description = "The namespace to deploy and release to in your Kubernetes cluster."
}

app "one" {
  labels = {
    "service" = "one",
    "env"     = "dev"
  }

  config {
    env = {
      WP_NODE = "ONE"
    }
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
      namespace = var.namespace

      ingress "http" {
        path_type = "Prefix"
        path      = "/app-one"
      }
    }
  }

}


app "two" {
  labels = {
    "service" = "two",
    "env"     = "dev"
  }

  config {
    env = {
      WP_NODE = "TWO"
    }
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
      namespace = var.namespace

      ingress "http" {
        path_type = "Prefix"
        path      = "/app-two"
      }
    }
  }
}
