module "cloudrun" {
  source = "../modules/cloudrun"
  service_name = "wordpress-app"
  region = var.region
  cloudsql_instance = module.sql_instance.connection_name 
  vpc_access_egress = "all-traffic"
  vpc = "wordpress"
  subnet = "wordpress-public-subnet-0"
  firewall_tags = ["basic","http"]
  container_name = "wordpress"
  image = "gcr.io/terraform-gcp-427717/app@sha256:3eb5ad87645c91d79ddd564359a491804d2b8001776dad2428c96073e032d293"
  port = 80
  env_vars = [
    {
      name  = "DB_USER"
      value = "root"
    },
    {
      name  = "DB_NAME"
      value = "wordpress"
    },
    {
      name  = "DB_PASSWORD"
      value = "admin"
    },
    {
      name  = "DB_HOST"
      value = ":/cloudsql/terraform-gcp-427717:us-central1:wordpress-db"
    }
  ]
}