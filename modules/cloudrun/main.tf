resource "google_cloud_run_service" "wordpress" {
  name     = var.service_name
  location = var.region

  template {
    metadata {
    annotations = {
        "run.googleapis.com/cloudsql-instances" = var.cloudsql_instance
        "run.googleapis.com/client-name"        = "cloud-console"
        "run.googleapis.com/startup-cpu-boost"  = var.startup_cpu_boost
        "run.googleapis.com/vpc-access-egress"  = var.vpc_access_egress
        "run.googleapis.com/network-interfaces" = jsonencode(
          [
            {
              network    = var.vpc
              subnetwork = var.subnet
              tags       = var.firewall_tags
            },
          ]
        )
      }
    }
    spec {
      containers {
        name = var.container_name
        image = var.image
        ports {
          container_port = var.port
        }
        dynamic "env" {
          for_each = var.env_vars
          content {
            name  = env.value.name
            value = env.value.value
          }
        }
      }
    }
  }

  traffic {
    percent         = var.traffic_percent
    latest_revision = var.latest_revision
  }
}