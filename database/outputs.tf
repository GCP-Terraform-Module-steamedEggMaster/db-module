## ======================================================
## database outputs
## ======================================================
output "id" {
  description = "Cloud SQL 데이터베이스의 고유 ID (Terraform 리소스 식별자)"
  value       = google_sql_database.database.id
}

output "name" {
  description = "Cloud SQL 데이터베이스 이름"
  value       = google_sql_database.database.name
}

output "instance" {
  description = "Cloud SQL 데이터베이스가 연결된 Cloud SQL 인스턴스 이름"
  value       = google_sql_database.database.instance
}

output "project" {
  description = "Cloud SQL 데이터베이스가 속한 GCP 프로젝트 ID"
  value       = google_sql_database.database.project
}

output "charset" {
  description = "Cloud SQL 데이터베이스에 설정된 문자셋 (예: UTF8)"
  value       = google_sql_database.database.charset
}

output "collation" {
  description = "Cloud SQL 데이터베이스에 설정된 Collation"
  value       = google_sql_database.database.collation
}