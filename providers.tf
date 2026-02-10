provider "tfe" {
  organization = var.tfe_org_name
}

provider "google" {
  region  = "global"
}

provider "google-beta" {
  region  = "global"
}
