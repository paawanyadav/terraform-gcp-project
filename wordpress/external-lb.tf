resource "google_compute_region_backend_service" "wordpress-backend" {
  name                 = "wordpress-app-backend"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  description                     = "wordpress-app-backend"
  port_name                       = "http"
  protocol                        = "HTTPS"
  region                          = "us-central1"
  timeout_sec                     = 30
  backend {
    balancing_mode               = "UTILIZATION"
    capacity_scaler              = 1
    failover                     = false
    group                        = google_compute_region_network_endpoint_group.cloudrun_neg.id
    }
}

resource "google_compute_region_url_map" "wordpress-app-lb" {
    name        = "wordpress-app-lb"
    default_service = google_compute_region_backend_service.wordpress-backend.self_link
}

resource "google_compute_forwarding_rule" "wordpress-http" {
  name                  = "wordpress-http"
  all_ports               = false
  allow_global_access     = false
  ip_protocol             = "TCP"
  is_mirroring_collector  = false
  load_balancing_scheme   = "EXTERNAL_MANAGED"
  network_tier            = "STANDARD"
  port_range              = "80-80"
  region                  = "us-central1"
  target                  = "https://www.googleapis.com/compute/v1/projects/terraform-gcp-427717/regions/us-central1/targetHttpProxies/wordpress-app-lb-target-proxy"
}