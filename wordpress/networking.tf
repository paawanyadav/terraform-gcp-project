module "vpc" {
  source                                    = "../modules/networking"
  network_name                              = "wordpress"
  auto_create_subnetworks                   = "false"
  routing_mode                              = "REGIONAL"
  project_id                                = var.project_id
  description                               = "wordpress-project"
  delete_default_internet_gateway_routes    = "false"
  create_nat                                = "true"
  region                                    = "us-central1"
  subnets = [
    {
      subnet_name         = "wordpress-public-subnet-0"
      subnet_ip           = "10.0.0.0/18"
      subnet_region       = "us-central1"
      subnet_private_access = "true"
      description         = "This is Public subnet 1"
    },
        {
      subnet_name         = "wordpress-private-subnet-1"
      subnet_ip           = "10.0.64.0/18"
      subnet_region       = "us-central1"
      subnet_private_access = "true"
      description         = "This is private subnet 2"
    },
    {
      subnet_name         = "wordpress-public-subnet-2"
      subnet_ip           = "10.0.128.0/18"
      subnet_region       = "us-central1"
      subnet_private_access = "true"
      description         = "This is Public subnet 3"
    },
    {
      subnet_name         = "wordpress-private-subnet-3"
      subnet_ip           = "10.0.192.0/18"
      subnet_region       = "us-central1"
      subnet_private_access = "true"
      description         = "This is private subnet 4"
    }
  ]
  ingress_rules = [
    {
      name              = "allow-basic"
      description       = "Allow SSH and HTTP from specific ranges"
      source_ranges     = ["10.0.0.0/18", "10.0.64.0/18", "10.0.128.0/18", "10.0.192.0/18"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["22", "80", "443"]
        }
      ]
      target_tags       = ["basic"]
      priority = "2000"
      deny = []
    },
    {
      name              = "allow-80"
      description       = "Allow HTTP from anywhere"
      source_ranges     = ["0.0.0.0/0"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["80"]
        }
      ]
      target_tags       = ["http"]
      priority = "3000"
      deny = []
    },
    {
      name              = "allow-https"
      description       = "Allow HTTPS from anywhere"
      source_ranges     = ["0.0.0.0/0"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["443"]
        }
      ]
      target_tags       = ["https"]
      priority = "4000"
      deny = []
    },
    {
      name              = "allow-ssh"
      description       = "Allow SSH from anywhere"
      source_ranges     = ["0.0.0.0/0"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["22"]
        }
      ]
      target_tags       = ["ssh"]
      priority = "5000"
      deny = []
    }
  ]

  egress_rules = [
    {
      name              = "allow-all-egress"
      description       = "Allow all outbound traffic"
      destination_ranges = ["0.0.0.0/0"]
      allow = [
        {
          protocol = "all"
        }
      ]
      target_tags       = ["allow-all-egress"]
      priority = "800"
      deny = []
    }
  ]
}