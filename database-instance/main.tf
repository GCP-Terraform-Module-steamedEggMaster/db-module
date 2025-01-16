resource "google_sql_database_instance" "database_instance" {
  name                = var.name                # 인스턴스 이름
  region              = var.region              # 리전 설정
  database_version    = var.database_version    # 데이터베이스 버전
  deletion_protection = var.deletion_protection # 삭제 보호
  project             = var.project             # GCP 프로젝트 ID
  root_password       = var.root_password       # 초기 루트 비밀번호

  settings {
    tier                         = var.settings.tier                         # 머신 유형
    availability_type            = var.settings.availability_type            # 가용성 설정
    activation_policy            = var.settings.activation_policy            # 활성화 정책
    disk_size                    = var.settings.disk_size                    # 디스크 크기
    disk_type                    = var.settings.disk_type                    # 디스크 유형
    enable_google_ml_integration = var.settings.enable_google_ml_integration # Vertex AI 통합 여부

    dynamic "advanced_machine_features" {
      for_each = var.settings.advanced_machine_features != null ? [1] : []
      content {
        threads_per_core = var.settings.advanced_machine_features.threads_per_core # CPU 코어당 스레드 수
      }
    }

    dynamic "database_flags" {
      for_each = var.settings.database_flags
      content {
        name  = database_flags.value.name  # 데이터베이스 플래그 이름
        value = database_flags.value.value # 데이터베이스 플래그 값
      }
    }

    dynamic "active_directory_config" {
      for_each = var.settings.active_directory_config != null ? [1] : []
      content {
        domain = var.settings.active_directory_config.domain # AD 도메인
      }
    }

    dynamic "deny_maintenance_period" {
      for_each = var.settings.deny_maintenance_period != null ? [1] : []
      content {
        start_date = var.settings.deny_maintenance_period.start_date # 유지보수 시작일
        end_date   = var.settings.deny_maintenance_period.end_date   # 유지보수 종료일
        time       = var.settings.deny_maintenance_period.time       # 유지보수 시간
      }
    }

    dynamic "sql_server_audit_config" {
      for_each = var.settings.sql_server_audit_config != null ? [1] : []
      content {
        bucket             = var.settings.sql_server_audit_config.bucket             # 감사 로그 버킷
        upload_interval    = var.settings.sql_server_audit_config.upload_interval    # 업로드 주기
        retention_interval = var.settings.sql_server_audit_config.retention_interval # 유지 기간
      }
    }

    dynamic "backup_configuration" {
      for_each = var.settings.backup_configuration != null ? [1] : []
      content {
        enabled                        = var.settings.backup_configuration.enabled                        # 백업 활성화 여부
        binary_log_enabled             = var.settings.backup_configuration.binary_log_enabled             # 바이너리 로그 활성화 여부
        start_time                     = var.settings.backup_configuration.start_time                     # 백업 시작 시간
        point_in_time_recovery_enabled = var.settings.backup_configuration.point_in_time_recovery_enabled # 시점 복구 활성화 여부
        location                       = var.settings.backup_configuration.location                       # 백업 저장 위치
      }
    }

    dynamic "ip_configuration" {
      for_each = var.settings.ip_configuration != null ? [1] : []
      content {
        ipv4_enabled                                  = var.settings.ip_configuration.ipv4_enabled                                  # IPv4 활성화 여부
        private_network                               = var.settings.ip_configuration.private_network                               # 프라이빗 네트워크
        ssl_mode                                      = var.settings.ip_configuration.ssl_mode                                      # SSL 모드
        enable_private_path_for_google_cloud_services = var.settings.ip_configuration.enable_private_path_for_google_cloud_services # Private Path 허용
        dynamic "authorized_networks" {
          for_each = lookup(var.settings.ip_configuration, "authorized_networks", [])
          content {
            expiration_time = authorized_networks.value.expiration_time # 허용 네트워크의 만료 시간
            name            = authorized_networks.value.name            # 허용 네트워크의 이름
            value           = authorized_networks.value.value           # 허용 네트워크의 CIDR
          }
        }
      }
    }

    dynamic "maintenance_window" {
      for_each = var.settings.maintenance_window != null ? [1] : []
      content {
        day          = var.settings.maintenance_window.day          # 유지보수 요일
        hour         = var.settings.maintenance_window.hour         # 유지보수 시간
        update_track = var.settings.maintenance_window.update_track # 업데이트 트랙
      }
    }
  }

  timeouts {
    create = var.timeout_create # 생성 제한 시간
    update = var.timeout_update # 업데이트 제한 시간
    delete = var.timeout_delete # 삭제 제한 시간
  }
}