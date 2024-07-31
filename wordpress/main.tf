resource "google_compute_global_address" "wordpress-gip" {
  name = "wordpress-app-global-ip"
}

resource "google_compute_health_check" "health-check" {
  name               = "wordpress-app-health-check"
  check_interval_sec = 10
  timeout_sec        = 5
  healthy_threshold  = 3
  unhealthy_threshold = 3

  http_health_check {
    request_path = "/"
    port         = 80
  }
}

resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  name                  = "wordpress-app-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = "wordpress-app"
  }
}


