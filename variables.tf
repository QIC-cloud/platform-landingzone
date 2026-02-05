# variable "oauth_client_id" {
#   type = string
# }

variable "tfe_org_name" {
  type = string
}
variable "workload_name" {
  type = string
}
variable "env" {
  type = string
}
variable "bu" {
  type = string
}
variable "github_owner" {
  type = string
}
variable "github_username" {
  type = string
}
# Copyright IBM Corp. 2022, 2025
# SPDX-License-Identifier: MPL-2.0

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
