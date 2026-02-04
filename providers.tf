terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    tfe = {
      version = "~> 0.73.0"
    }
  }
}

provider "github" {

}

provider "tfe" {
  organization = var.tfe_org_name
}
