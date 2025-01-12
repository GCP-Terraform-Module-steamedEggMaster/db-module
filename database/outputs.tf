## ======================================================
## google_sql_database outputs
## ======================================================
output "id" {
  description = "Cloud SQL 데이터베이스의 고유 ID"
  value       = google_sql_database.database.id
}

output "name" {
  description = "Cloud SQL 데이터베이스의 이름"
  value       = google_sql_database.database.name
}

output "self_link" {
  description = "Cloud SQL 데이터베이스 리소스의 URI"
  value       = google_sql_database.database.self_link
}