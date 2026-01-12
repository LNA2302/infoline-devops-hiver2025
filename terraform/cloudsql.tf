resource "google_sql_database_instance" "postgres_infoline" {
  name             = "postgres-infoline"
  database_version = "POSTGRES_15"
  region           = "us-central1"

  settings {
    tier = "db-f1-micro"   # plus petite instance possible

    ip_configuration {
      ipv4_enabled = true
    }

    backup_configuration {
      enabled = false
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "infoline_db" {
  name     = "infoline_db"
  instance = google_sql_database_instance.postgres_infoline.name
}

resource "google_sql_user" "infoline_user" {
  name     = "infoline_user"
  instance = google_sql_database_instance.postgres_infoline.name
  password = "ChangeMe123!"
}
