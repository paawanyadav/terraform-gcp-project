resource "google_compute_region_backend_service" "wordpress-internal-backend" {
  name                 = "wordpress-app-private-backend"
  load_balancing_scheme = "INTERNAL_MANAGED"
  description                     = "wordpress-app-private-backend"
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

resource "google_compute_region_url_map" "wordpress-app-internal-lb" {
    name        = "wordpress-app-internal-lb"
    default_service = google_compute_region_backend_service.wordpress-internal-backend.self_link
}

resource "google_compute_forwarding_rule" "wordpress-internal-http" {
  name                  = "wordpress-internal-http"
  all_ports               = false
  allow_global_access     = false
  ip_protocol             = "TCP"
  is_mirroring_collector  = false
  load_balancing_scheme   = "INTERNAL_MANAGED"
  network_tier            = "PREMIUM"
  port_range              = "80-80"
  region                  = "us-central1"
  target                  = "https://www.googleapis.com/compute/v1/projects/terraform-gcp-427717/regions/us-central1/targetHttpProxies/wordpress-app-internal-lb-target-proxy"
}