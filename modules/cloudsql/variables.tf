variable "instance_name" {
  type = string
}
variable "db_version" {
  type = string
}
variable "region" {
  type = string
}
variable "project_id" {
  type = string
}
variable "tier" {
  type = string
}
variable "private_network" {
  type = string
}
variable "ipv4_enabled" {
  type = bool
  default = false
}
variable "database_name" {
  type = string
}