provider "tfe" {
  organization = var.tfe_org_name
}

provider "google" {
  project = var.gcp_project_id
  region  = "global"
}

provider "google-beta" {
  project = var.gcp_project_id
  region  = "global"
}
