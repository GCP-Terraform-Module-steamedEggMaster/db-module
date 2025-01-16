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

output "host" {
  description = "Cloud SQL 사용자 접속 호스트 (MySQL 전용)"
  value       = google_sql_user.user.host
}

output "type" {
  description = "Cloud SQL 사용자의 인증 유형 (SQL 또는 IAM)"
  value       = google_sql_user.user.type
}

output "deletion_policy" {
  description = "Cloud SQL 사용자 삭제 정책"
  value       = google_sql_user.user.deletion_policy
}