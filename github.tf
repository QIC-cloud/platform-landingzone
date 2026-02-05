resource "github_repository" "workload_landingzone_repo" {
  name        = "workload-landingzone"
  description = "This is a fork of workload landingzone repository"
  visibility  = "public"

  source_owner = "AllaeddineEL"
  source_repo  = "simple-gcp-landingzone"

  fork                 = true
  vulnerability_alerts = false
}
resource "github_release" "workload_landingzone_repo_release" {
  repository = github_repository.workload_landingzone_repo.name

  tag_name = "v1.0.0"
}
