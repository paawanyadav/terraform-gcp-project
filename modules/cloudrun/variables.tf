variable "traffic_percent" {
  default = 100
}
variable "latest_revision" {
  default = true
}
variable "port" {
  type = number
}
variable "image" {
  type = string
}
variable "container_name" {
  type = string
}
variable "firewall_tags" {
  type = list
}
variable "subnet" {
    type = string
}
variable "vpc" {
    type = string
}
variable "vpc_access_egress" {
    type = string
}
variable "startup_cpu_boost" {
  type = bool
  default = false
}
variable "cloudsql_instance" {
  type = string
}
variable "region" {
  type = string
}
variable "service_name" {
  type = string
}

variable "env_vars" {
  description = "List of environment variables for the Cloud Run service"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}