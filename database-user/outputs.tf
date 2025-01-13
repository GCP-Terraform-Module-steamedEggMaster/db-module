## ======================================================
## google_sql_user outputs
## ======================================================
output "id" {
  description = "Cloud SQL 사용자의 고유 ID"
  value       = google_sql_user.user.id
}

output "name" {
  description = "Cloud SQL 사용자의 이름"
  value       = google_sql_user.user.name
}

output "instance" {
  description = "Cloud SQL 사용자가 속한 인스턴스 이름"
  value       = google_sql_user.user.instance
}

output "project" {
  description = "Cloud SQL 사용자가 속한 GCP 프로젝트 ID"
  value       = google_sql_user.user.project
}

output "type" {
  description = "Cloud SQL 사용자 인증 유형"
  value       = google_sql_user.user.type
}