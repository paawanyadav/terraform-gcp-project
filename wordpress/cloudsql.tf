module "sql_instance" {
  source = "../modules/cloudsql"
  instance_name = "wordpress-db"
  db_version = "MYSQL_8_0"
  region = var.region
  project_id = var.project_id
  tier = "db-f1-micro"
  private_network = module.vpc.vpc_network_id
  database_name = "wordpress"
}