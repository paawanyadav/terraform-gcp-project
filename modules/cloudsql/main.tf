resource "google_sql_database_instance" "sql_instance" {
  name             = var.instance_name
  database_version = var.db_version
  region           = var.region
  project          = var.project_id

  settings {
    tier = var.tier
    ip_configuration {
      private_network = var.private_network
      ipv4_enabled    = var.ipv4_enabled
    }
  }
}

resource "google_sql_database" "default" {
  name     = var.database_name
  instance = google_sql_database_instance.sql_instance.name
  project  = var.project_id
  depends_on = [
    google_sql_database_instance.sql_instance
  ]
}