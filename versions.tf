terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "> 0.50.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "> 3.73.0"
    }
  }
  cloud { 
    
    organization = "Qiddiya" 

    workspaces { 
      name = "platform-landingzone-test" 
    } 
}
}