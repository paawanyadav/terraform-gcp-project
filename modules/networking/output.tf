output "vpc_network_id" {
  description = "The unique identifier of the VPC network."
  value       = google_compute_network.vpc.id
}