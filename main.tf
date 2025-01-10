resource "google_sql_database_instance" "database" {
  # 필수 옵션
  name             = var.name             # 인스턴스 이름
  database_version = var.database_version # 데이터베이스 버전
  region           = var.region           # 리전

  # 설정 블록
  settings {
    # 기본 머신 및 디스크 설정
    tier              = var.tier              # 머신 타입
    availability_type = var.availability_type # 고가용성 유형 (ZONAL/REGIONAL)
    disk_size         = var.disk_size         # 디스크 크기 (GB)
    disk_type         = var.disk_type         # 디스크 타입 (PD_SSD/PD_HDD)
    activation_policy = var.activation_policy # 활성화 정책 (ALWAYS, ON_DEMAND 등)
    collation         = var.collation         # 데이터베이스 콜레이션 설정

    # 백업 설정
    backup_configuration {
      enabled                        = var.backup_enabled                 # 백업 활성화 여부
      start_time                     = var.backup_start_time              # 백업 시작 시간 (HH:MM)
      point_in_time_recovery_enabled = var.point_in_time_recovery_enabled # PITR 활성화 여부
      binary_log_enabled             = var.binary_log_enabled             # 바이너리 로그 활성화 (MySQL용)
      location                       = var.backup_location                # 백업 위치
      transaction_log_retention_days = var.transaction_log_retention_days # 트랜잭션 로그 보존 일수
    }

    # 디스크 자동 크기 조정 설정
    disk_autoresize       = var.disk_autoresize       # 디스크 자동 크기 조정 활성화
    disk_autoresize_limit = var.disk_autoresize_limit # 디스크 자동 크기 조정 제한 (GB)

    # IP 설정
    ip_configuration {
      ipv4_enabled                                  = var.ipv4_enabled        # IPv4 활성화 여부
      private_network                               = var.private_network     # 프라이빗 네트워크
      allocated_ip_range                            = var.allocated_ip_range  # IP 범위
      enable_private_path_for_google_cloud_services = var.enable_private_path # 구글 서비스에 대한 프라이빗 IP 경로 활성화
      ssl_mode                                      = var.ssl_mode            # SSL 연결 설정
    }

    # 유지 관리 창 설정
    maintenance_window {
      day          = var.maintenance_day          # 유지 관리 요일 (1-7, 월요일 시작)
      hour         = var.maintenance_hour         # 유지 관리 시작 시간 (0-23)
      update_track = var.maintenance_update_track # 업데이트 트랙 (stable, canary 등)
    }

    # Query Insights 설정
    insights_config {
      query_insights_enabled  = var.query_insights_enabled  # Query Insights 활성화
      query_string_length     = var.query_string_length     # 쿼리 문자열 최대 길이
      record_application_tags = var.record_application_tags # 애플리케이션 태그 기록
      record_client_address   = var.record_client_address   # 클라이언트 주소 기록
    }

    # 사용자 정의 레이블
    user_labels = var.user_labels # 사용자 정의 레이블

    # 고급 머신 설정
    advanced_machine_features {
      threads_per_core = var.threads_per_core # 코어당 스레드 수
    }

    # SQL Server 감사 설정
    sql_server_audit_config {
      bucket             = var.audit_bucket             # 감사 로그를 저장할 버킷
      upload_interval    = var.audit_upload_interval    # 로그 업로드 간격
      retention_interval = var.audit_retention_interval # 로그 보존 기간
    }

    # 비밀번호 정책 설정
    password_validation_policy {
      min_length                  = var.password_min_length                  # 비밀번호 최소 길이
      complexity                  = var.password_complexity                  # 비밀번호 복잡성 설정
      reuse_interval              = var.password_reuse_interval              # 비밀번호 재사용 금지 간격
      disallow_username_substring = var.password_disallow_username_substring # 비밀번호에 사용자 이름 금지
      password_change_interval    = var.password_change_interval             # 비밀번호 변경 최소 간격
      enable_password_policy      = var.password_policy_enabled              # 비밀번호 정책 활성화 여부
    }
  }

  # 삭제 보호
  deletion_protection = var.deletion_protection # 삭제 보호 활성화 여부

  # 암호화 설정
  encryption_key_name = var.encryption_key_name # CMEK 암호화 키 이름

  # 복제 설정
  replica_configuration {
    failover_target = var.replica_failover_target # Failover 대상 여부
    username        = var.replica_username        # 복제 연결 사용자 이름
    password        = var.replica_password        # 복제 연결 비밀번호
  }

  # 프로젝트
  project = var.project # GCP 프로젝트 ID
}
