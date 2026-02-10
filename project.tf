data "google_secret_manager_secret_version" "billing_id" {
  secret  = "billing"
  project = "common-iac"
}

module "gcp-project-factory" {
  source  = "app.terraform.io/Qiddiya/gcp-project-factory/google"
  version = "1.0.0"
  # insert required variables here
  billing_account = data.google_secret_manager_secret_version.billing_id.secret_data
  folder_id       = var.folder_id
  project_id      = "${var.bu}-${var.workload_name}-${var.env}"
  name            = "${var.bu}-${var.workload_name}-${var.env}"
  labels = {
    environment = var.env
    owner       = var.bu
  }
}