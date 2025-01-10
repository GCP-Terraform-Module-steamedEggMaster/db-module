resource "google_sql_database_instance" "database" {
  name             = var.name
  database_version = var.database_version
  region           = var.region

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_size         = var.disk_size
    disk_type         = var.disk_type
    activation_policy = var.activation_policy
    collation         = var.collation

    # 백업 설정 (조건부로 포함)
    dynamic "backup_configuration" {
      for_each = var.backup_enabled ? [1] : []
      content {
        enabled                        = var.backup_enabled
        start_time                     = var.backup_start_time
        point_in_time_recovery_enabled = var.point_in_time_recovery_enabled
        binary_log_enabled             = var.binary_log_enabled
        location                       = var.backup_location
        transaction_log_retention_days = var.transaction_log_retention_days
      }
    }

    # 디스크 자동 크기 조정 설정
    disk_autoresize       = var.disk_autoresize
    disk_autoresize_limit = var.disk_autoresize_limit

    # IP 설정 (조건부로 포함)
    dynamic "ip_configuration" {
      for_each = var.private_network != null || var.ipv4_enabled ? [1] : []
      content {
        ipv4_enabled        = var.ipv4_enabled
        private_network     = var.private_network
        allocated_ip_range  = var.allocated_ip_range
        ssl_mode            = var.ssl_mode
        enable_private_path_for_google_cloud_services = var.enable_private_path
      }
    }

    # 유지 관리 창 설정 (조건부로 포함)
    dynamic "maintenance_window" {
      for_each = var.maintenance_day != null && var.maintenance_hour != null ? [1] : []
      content {
        day          = var.maintenance_day
        hour         = var.maintenance_hour
        update_track = var.maintenance_update_track
      }
    }

    # Query Insights 설정 (조건부로 포함)
    dynamic "insights_config" {
      for_each = var.query_insights_enabled ? [1] : []
      content {
        query_insights_enabled  = var.query_insights_enabled
        query_string_length     = var.query_string_length
        record_application_tags = var.record_application_tags
        record_client_address   = var.record_client_address
      }
    }

    # 사용자 정의 레이블
    user_labels = var.user_labels

    # 고급 머신 설정 (조건부로 포함)
    dynamic "advanced_machine_features" {
      for_each = var.threads_per_core != null ? [1] : []
      content {
        threads_per_core = var.threads_per_core
      }
    }

    # SQL Server 감사 설정 (조건부로 포함)
    dynamic "sql_server_audit_config" {
      for_each = var.audit_bucket != null ? [1] : []
      content {
        bucket             = var.audit_bucket
        upload_interval    = var.audit_upload_interval
        retention_interval = var.audit_retention_interval
      }
    }

    # 비밀번호 정책 설정 (조건부로 포함)
    dynamic "password_validation_policy" {
      for_each = var.password_policy_enabled ? [1] : []
      content {
        min_length                  = var.password_min_length
        complexity                  = var.password_complexity
        reuse_interval              = var.password_reuse_interval
        disallow_username_substring = var.password_disallow_username_substring
        password_change_interval    = var.password_change_interval
        enable_password_policy      = var.password_policy_enabled
      }
    }
  }

  # 삭제 보호
  deletion_protection = var.deletion_protection

  # 암호화 설정 (조건부로 포함)
  encryption_key_name = var.encryption_key_name != null ? var.encryption_key_name : null

  # 복제 설정 (조건부로 포함)
  dynamic "replica_configuration" {
    for_each = var.replica_failover_target != null ? [1] : []
    content {
      failover_target = var.replica_failover_target
      username        = var.replica_username
      password        = var.replica_password
    }
  }

  project = var.project
}
