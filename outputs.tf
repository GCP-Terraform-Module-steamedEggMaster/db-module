output "id" {
  description = "Cloud SQL 인스턴스의 고유 ID"
  value       = google_sql_database_instance.instance.id
}

output "name" {
  description = "Cloud SQL 인스턴스의 이름"
  value       = google_sql_database_instance.instance.name
}

output "self_link" {
  description = "Cloud SQL 인스턴스의 고유 URI"
  value       = google_sql_database_instance.instance.self_link
}

output "connection_name" {
  description = "Cloud SQL 인스턴스의 연결 이름"
  value       = google_sql_database_instance.instance.connection_name
}

output "region" {
  description = "Cloud SQL 인스턴스가 위치한 GCP 리전"
  value       = google_sql_database_instance.instance.region
}

output "project" {
  description = "Cloud SQL 인스턴스가 속한 GCP 프로젝트 ID"
  value       = google_sql_database_instance.instance.project
}

output "database_version" {
  description = "Cloud SQL 인스턴스의 데이터베이스 버전"
  value       = google_sql_database_instance.instance.database_version
}

output "tier" {
  description = "Cloud SQL 인스턴스의 머신 타입"
  value       = try(google_sql_database_instance.instance.settings[0].tier, null)
}

output "disk_size" {
  description = "Cloud SQL 인스턴스의 디스크 크기 (GB)"
  value       = try(google_sql_database_instance.instance.settings[0].disk_size, null)
}

output "availability_type" {
  description = "Cloud SQL 인스턴스의 고가용성 유형"
  value       = try(google_sql_database_instance.instance.settings[0].availability_type, null)
}

output "ip_addresses" {
  description = "Cloud SQL 인스턴스의 IP 주소 목록"
  value       = google_sql_database_instance.instance.ip_address
}

output "private_network" {
  description = "Cloud SQL 인스턴스가 연결된 프라이빗 네트워크"
  value       = try(google_sql_database_instance.instance.settings[0].ip_configuration[0].private_network, null)
}

output "ipv4_enabled" {
  description = "Cloud SQL 인스턴스의 IPv4 활성화 여부"
  value       = try(google_sql_database_instance.instance.settings[0].ip_configuration[0].ipv4_enabled, null)
}

output "ssl_enforcement" {
  description = "SSL 연결 정책"
  value       = try(google_sql_database_instance.instance.settings[0].ip_configuration[0].ssl_mode, null)
}

output "backup_configuration" {
  description = "Cloud SQL 인스턴스의 백업 설정"
  value = {
    enabled                        = try(google_sql_database_instance.instance.settings[0].backup_configuration[0].enabled, false)
    start_time                     = try(google_sql_database_instance.instance.settings[0].backup_configuration[0].start_time, null)
    point_in_time_recovery_enabled = try(google_sql_database_instance.instance.settings[0].backup_configuration[0].point_in_time_recovery_enabled, false)
    binary_log_enabled             = try(google_sql_database_instance.instance.settings[0].backup_configuration[0].binary_log_enabled, false)
    location                       = try(google_sql_database_instance.instance.settings[0].backup_configuration[0].location, null)
    transaction_log_retention_days = try(google_sql_database_instance.instance.settings[0].backup_configuration[0].transaction_log_retention_days, null)
  }
}

output "query_insights" {
  description = "Query Insights 설정"
  value = {
    query_insights_enabled  = try(google_sql_database_instance.instance.settings[0].insights_config[0].query_insights_enabled, false)
    query_string_length     = try(google_sql_database_instance.instance.settings[0].insights_config[0].query_string_length, null)
    record_application_tags = try(google_sql_database_instance.instance.settings[0].insights_config[0].record_application_tags, false)
    record_client_address   = try(google_sql_database_instance.instance.settings[0].insights_config[0].record_client_address, false)
  }
}

output "maintenance_window" {
  description = "유지 관리 창 설정"
  value = {
    day          = try(google_sql_database_instance.instance.settings[0].maintenance_window[0].day, null)
    hour         = try(google_sql_database_instance.instance.settings[0].maintenance_window[0].hour, null)
    update_track = try(google_sql_database_instance.instance.settings[0].maintenance_window[0].update_track, null)
  }
}

output "labels" {
  description = "Cloud SQL 인스턴스에 설정된 사용자 정의 레이블"
  value       = try(google_sql_database_instance.instance.settings[0].user_labels, {})
}

output "replica_names" {
  description = "Cloud SQL 인스턴스의 복제본 이름 목록"
  value       = google_sql_database_instance.instance.replica_names
}

output "deletion_protection" {
  description = "Cloud SQL 인스턴스의 삭제 보호 상태"
  value       = google_sql_database_instance.instance.deletion_protection
}