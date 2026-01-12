resource "google_storage_bucket" "function_bucket" {
  name          = "function-infoline-code"
  location      = "US"
  force_destroy = true
}

resource "google_storage_bucket_object" "function_zip" {
  name   = "function.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = "../function/function.zip"
}

resource "google_cloudfunctions_function" "login_function" {
  name        = "login-function"
  description = "Cloud Function de login"
  runtime     = "python39"

  available_memory_mb = 128
  timeout             = 60

  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.function_zip.name
  entry_point           = "login"

  trigger_http = true

  region = "us-central1"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.login_function.project
  region         = google_cloudfunctions_function.login_function.region
  cloud_function = google_cloudfunctions_function.login_function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
