data "tfe_organization" "org" {
}
resource "tfe_project" "proj" {
  organization = data.tfe_organization.org.name
  name         = "${var.bu}-${var.workload_name}-${var.env}"
  tags = {
    cost_center = var.bu
    team        = "${var.bu}-${var.workload_name}"
  }
}
resource "tfe_team" "team" {
  name         = "${var.bu}-${var.workload_name}-${var.env}"
  organization = data.tfe_organization.org.name
}
data "tfe_organization_membership" "team_members" {
  for_each     = toset(var.team_members)
  organization = data.tfe_organization.org.name
  username     = each.key
}
resource "tfe_team_organization_members" "team_members" {
  team_id                     = tfe_team.team.id
  organization_membership_ids = [for member in toset(var.team_members) : data.tfe_organization_membership.team_members[member].id]
}
resource "tfe_team_project_access" "custom_project_access" {
  access     = "custom"
  team_id    = tfe_team.team.id
  project_id = tfe_project.proj.id
  project_access {
    settings      = "read"
    teams         = "none"
    variable_sets = "none"
  }
  workspace_access {
    state_versions = "write"
    sentinel_mocks = "none"
    runs           = "apply"
    variables      = "write"
    create         = true
    locking        = true
    move           = false
    delete         = true
    run_tasks      = false
  }
}
resource "tfe_variable" "enable_gcp_provider_auth" {
  variable_set_id = tfe_variable_set.varset.id
  key             = "TFC_GCP_PROVIDER_AUTH"
  value           = "true"
  category        = "env"
  description     = "Enable the Workload Identity integration for GCP."
}
resource "tfe_variable" "tfc_gcp_workload_provider_name" {
  variable_set_id = tfe_variable_set.varset.id
  key             = "TFC_GCP_WORKLOAD_PROVIDER_NAME"
  value           = google_iam_workload_identity_pool_provider.tfc_provider.name
  category        = "env"
  description     = "The workload provider name to authenticate against."
}
resource "tfe_variable" "tfc_gcp_service_account_email" {
  variable_set_id = tfe_variable_set.varset.id
  key             = "TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL"
  value           = google_service_account.tfc_service_account.email
  category        = "env"
  description     = "The GCP service account email runs will use to authenticate."
}

resource "tfe_variable_set" "varset" {
  name              = "${var.bu}-${var.workload_name}-${var.env}-varset"
  description       = "Var Set for Dynamic GCP."
  global            = false
  parent_project_id = tfe_project.proj.id
}
resource "tfe_project_variable_set" "default" {
  variable_set_id = tfe_variable_set.varset.id
  project_id      = tfe_project.proj.id
}
