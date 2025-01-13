resource "google_sql_database_instance" "database_instance" {
  name             = var.name             # 데이터베이스 인스턴스 이름
  database_version = var.database_version # 데이터베이스 버전 (예: POSTGRES_13)
  region           = var.region           # 인스턴스가 생성될 GCP 리전

  settings {                                  # 데이터베이스 인스턴스의 설정 블록
    tier              = var.tier              # 인스턴스 머신 타입 (예: db-f1-micro)
    availability_type = var.availability_type # 고가용성 설정 (예: ZONAL, REGIONAL)
    disk_size         = var.disk_size         # 디스크 크기 (GB 단위)
    disk_type         = var.disk_type         # 디스크 유형 (PD_SSD 또는 PD_HDD)
    activation_policy = var.activation_policy # 인스턴스 활성화 정책 (ALWAYS 또는 ON_DEMAND)
    collation         = var.collation         # 데이터베이스의 정렬 설정 (콜레이션)

    # 백업 설정 (조건부로 포함)
    dynamic "backup_configuration" {
      for_each = var.backup_enabled ? [1] : [] # 백업이 활성화된 경우에만 블록 포함
      content {
        enabled                        = var.backup_enabled                 # 백업 활성화 여부
        start_time                     = var.backup_start_time              # 백업 시작 시간 (HH:MM 형식)
        point_in_time_recovery_enabled = var.point_in_time_recovery_enabled # 특정 시점 복구(PITR) 활성화 여부
        binary_log_enabled             = var.binary_log_enabled             # 바이너리 로그 활성화 여부 (MySQL 전용)
        location                       = var.backup_location                # 백업 저장 위치
        transaction_log_retention_days = var.transaction_log_retention_days # 트랜잭션 로그 보존 기간 (일 단위)
      }
    }

    disk_autoresize       = var.disk_autoresize       # 디스크 자동 크기 조정 활성화 여부
    disk_autoresize_limit = var.disk_autoresize_limit # 디스크 자동 크기 조정 제한 (GB 단위)

    # IP 설정 (조건부로 포함)
    dynamic "ip_configuration" {
      for_each = var.private_network != null || var.ipv4_enabled ? [1] : [] # IPv4 또는 프라이빗 네트워크가 활성화된 경우 포함
      content {
        ipv4_enabled                                  = var.ipv4_enabled        # IPv4 활성화 여부
        private_network                               = var.private_network     # 프라이빗 네트워크 URI
        allocated_ip_range                            = var.allocated_ip_range  # 할당된 IP 범위
        ssl_mode                                      = var.ssl_mode            # SSL 설정 모드
        enable_private_path_for_google_cloud_services = var.enable_private_path # Google Cloud 서비스의 프라이빗 경로 활성화 여부


        # Authorized Networks 추가
        dynamic "authorized_networks" {
          for_each = var.authorized_networks
          content {
            value           = authorized_networks.value.value                      # 허용된 네트워크 CIDR
            name            = try(authorized_networks.value.name, null)            # 네트워크 이름 (Optional)
            expiration_time = try(authorized_networks.value.expiration_time, null) # 만료 시간 (Optional)
          }
        }
      }
    }

    # 유지 관리 창 설정 (조건부로 포함)
    dynamic "maintenance_window" {
      for_each = var.maintenance_day != null && var.maintenance_hour != null ? [1] : [] # 유지 관리 창이 설정된 경우 포함
      content {
        day          = var.maintenance_day          # 유지 관리 요일 (1-7, 월요일 시작)
        hour         = var.maintenance_hour         # 유지 관리 시작 시간 (0-23)
        update_track = var.maintenance_update_track # 업데이트 트랙 (stable 또는 canary)
      }
    }

    # Query Insights 설정 (조건부로 포함)
    dynamic "insights_config" {
      for_each = var.query_insights_enabled ? [1] : [] # Query Insights가 활성화된 경우 포함
      content {
        query_insights_enabled  = var.query_insights_enabled  # Query Insights 활성화 여부
        query_string_length     = var.query_string_length     # Query 문자열 최대 길이
        record_application_tags = var.record_application_tags # 애플리케이션 태그 기록 여부
        record_client_address   = var.record_client_address   # 클라이언트 주소 기록 여부
      }
    }

    user_labels = var.user_labels # 사용자 정의 레이블 추가

    # 고급 머신 설정 (조건부로 포함)
    dynamic "advanced_machine_features" {
      for_each = var.threads_per_core != null ? [1] : [] # 고급 머신 설정이 제공된 경우 포함
      content {
        threads_per_core = var.threads_per_core # 코어당 스레드 수 설정
      }
    }

    # SQL Server 감사 설정 (조건부로 포함)
    dynamic "sql_server_audit_config" {
      for_each = var.audit_bucket != null ? [1] : [] # 감사 설정이 제공된 경우 포함
      content {
        bucket             = var.audit_bucket             # 감사 로그를 저장할 버킷
        upload_interval    = var.audit_upload_interval    # 감사 로그 업로드 간격
        retention_interval = var.audit_retention_interval # 감사 로그 보존 기간
      }
    }

    # 비밀번호 정책 설정 (조건부로 포함)
    dynamic "password_validation_policy" {
      for_each = var.password_policy_enabled ? [1] : [] # 비밀번호 정책이 활성화된 경우 포함
      content {
        min_length                  = var.password_min_length                  # 비밀번호 최소 길이
        complexity                  = var.password_complexity                  # 비밀번호 복잡성
        reuse_interval              = var.password_reuse_interval              # 비밀번호 재사용 금지 간격
        disallow_username_substring = var.password_disallow_username_substring # 사용자 이름 포함 금지 여부
        password_change_interval    = var.password_change_interval             # 비밀번호 변경 최소 간격
        enable_password_policy      = var.password_policy_enabled              # 비밀번호 정책 활성화 여부
      }
    }
  }

  deletion_protection = var.deletion_protection # 삭제 보호 활성화 여부

  # 암호화 설정 (조건부로 포함)
  encryption_key_name = var.encryption_key_name != null ? var.encryption_key_name : null # 암호화 키 이름 설정

  # 복제 설정 (조건부로 포함)
  dynamic "replica_configuration" {
    for_each = var.replica_failover_target != null ? [1] : [] # 복제 설정이 제공된 경우 포함
    content {
      failover_target = var.replica_failover_target # 장애 조치 대상 여부
      username        = var.replica_username        # 복제 사용자 이름
      password        = var.replica_password        # 복제 사용자 비밀번호
    }
  }

  project = var.project # GCP 프로젝트 ID
}