data "tfe_organization" "org" {
}
resource "tfe_project" "proj" {
  organization = data.tfe_organization.org.name
  name         = "${var.bu}-${var.workload_name}-${var.env}"
  tags = {
    cost_center = "infrastructure"
    team        = "platform"
  }
}
resource "tfe_variable_set" "varset" {
  name              = "${var.bu}-${var.workload_name}-${var.env}-varset"
  description       = "Var Set for Dynamic GCP."
  global            = false
  parent_project_id = tfe_project.proj.id
}
resource "tfe_variable" "enable_gcp_provider_auth" {
  variable_set_id = tfe_variable_set.varset.id

  key      = "TFC_GCP_PROVIDER_AUTH"
  value    = "true"
  category = "env"

  description = "Enable the Workload Identity integration for GCP."
}
resource "tfe_variable" "tfc_gcp_workload_provider_name" {
  variable_set_id = tfe_variable_set.varset.id

  key      = "TFC_GCP_WORKLOAD_PROVIDER_NAME"
  value    = google_iam_workload_identity_pool_provider.tfc_provider.name
  category = "env"

  description = "The workload provider name to authenticate against."
}
resource "tfe_variable" "tfc_gcp_service_account_email" {
  variable_set_id = tfe_variable_set.varset.id

  key      = "TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL"
  value    = google_service_account.tfc_service_account.email
  category = "env"

  description = "The GCP service account email runs will use to authenticate."
}
data "tfe_github_app_installation" "gha_installation" {
  name = var.github_username
}

resource "tfe_registry_module" "basic_lz" {
  name         = "gcp-compute-landingzone"
  organization = data.tfe_organization.org.name
  vcs_repo {
    display_identifier         = github_repository.workload_landingzone_repo.full_name
    identifier                 = github_repository.workload_landingzone_repo.full_name
    github_app_installation_id = data.tfe_github_app_installation.gha_installation.id
    tag_prefix                 = "v1.0.0"
  }

  #module_provider = "gcp"
}
