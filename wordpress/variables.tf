variable "project_id" {
  type           = string
  description  = "Project ID"
  default        = "terraform-gcp-427717"
}

variable "region" {
  type           = string
  default        = "us-central1"
}

variable "name" {
  type           = string
  default       = "wordpress"
}

variable "ip_cidr_range" {
  type=list(string)
  default=["10.0.0.0/18", "10.0.64.0/18", "10.0.128.0/18", "10.0.192.0/18"]
}