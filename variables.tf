# variable "oauth_client_id" {
#   type = string
# }

variable "tfe_org_name" {
  type        = string
  description = "Set your HCP Terraform Org. Name"
}
variable "workload_name" {
  type        = string
  description = "Set your Workload/Application Name"
}
variable "env" {
  type        = string
  description = "Set your Workload/Application Environment Name e.g. dev, staging, prod"
}
variable "bu" {
  type        = string
  description = "Set the business unit name of the Workload (Workload Owner)"
}
variable "team_members" {
  type        = list()
  description = "A comma-separated list of Team usernames. e.g. user1,user2"
}

variable "tfc_gcp_audience" {
  type        = string
  default     = ""
  description = "The audience value to use in run identity tokens if the default audience value is not desired."
}

variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance you'd like to use with GCP"
}


variable "gcp_project_id" {
  type        = string
  description = "The ID for your GCP project"
}

variable "gcp_service_list" {
  description = "APIs required for the project"
  type        = list(string)
  default = [
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "sts.googleapis.com",
    "iamcredentials.googleapis.com"
  ]
}
