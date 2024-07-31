resource "google_compute_network" "vpc" {
  name                                      = var.network_name
  auto_create_subnetworks                   = var.auto_create_subnetworks
  routing_mode                              = var.routing_mode
  project                                   = var.project_id
  description                               = var.description
  delete_default_routes_on_create           = var.delete_default_internet_gateway_routes
  mtu                                       = var.mtu
  enable_ula_internal_ipv6                  = var.enable_ipv6_ula
  internal_ipv6_range                       = var.internal_ipv6_range
  network_firewall_policy_enforcement_order = var.network_firewall_policy_enforcement_order
}

resource "google_compute_subnetwork" "subnet" {
  for_each                   = local.subnets
  name                       = each.value.subnet_name
  ip_cidr_range              = each.value.subnet_ip
  region                     = each.value.subnet_region
  private_ip_google_access   = lookup(each.value, "subnet_private_access", "false")
  description = lookup(each.value, "description", null)
  network     = google_compute_network.vpc.id
  project     = var.project_id
}

resource "google_compute_router" "nat" {
  count   = var.create_nat ? 1 : 0
  name    = "${var.network_name}-public-router"
  region  = var.region
  network = google_compute_network.vpc.id
  depends_on = [
    google_compute_network.vpc
  ]
}

resource "google_compute_router_nat" "this" {
  count   = var.create_nat ? 1 : 0
  name                               = "${var.network_name}-public-router-nat"
  router                             = google_compute_router.nat[count.index].name
  region                             = google_compute_router.nat[count.index].region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
    subnetwork {
    name                     = "${var.network_name}-public-subnet-0"
    source_ip_ranges_to_nat  = ["ALL_IP_RANGES"]
  }

  subnetwork {
    name                     = "${var.network_name}-public-subnet-2"
    source_ip_ranges_to_nat  = ["ALL_IP_RANGES"]
  }
  depends_on = [
    google_compute_subnetwork.subnet
  ]
}