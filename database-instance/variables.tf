# 인스턴스 이름
variable "name" {
  description = "Cloud SQL 인스턴스의 이름 (생성된 인스턴스의 고유 식별자)."
  type        = string
}

# GCP 리전
variable "region" {
  description = "Cloud SQL 인스턴스가 생성될 리전 (예: us-central1)."
  type        = string
}

# 데이터베이스 버전
variable "database_version" {
  description = "Cloud SQL 인스턴스의 데이터베이스 버전 (예: MYSQL_5_7, POSTGRES_13)."
  type        = string
}

# 삭제 보호
variable "deletion_protection" {
  description = "Terraform을 통해 인스턴스 삭제를 방지할지 여부 (기본값: false)."
  type        = bool
  default     = false
}

# GCP 프로젝트 ID
variable "project" {
  description = "Cloud SQL 인스턴스가 속한 GCP 프로젝트 ID."
  type        = string
  default     = null
}

# 초기 루트 비밀번호
variable "root_password" {
  description = "Cloud SQL 인스턴스의 초기 루트 사용자 비밀번호."
  type        = string
  default     = null
}

# 설정
variable "settings" {
  description = "Cloud SQL 인스턴스의 설정 (머신 유형, 디스크 설정 등)."
  type = object({
    tier                         = string                     # 머신 유형 (예: db-n1-standard-1)
    availability_type            = optional(string, "ZONAL")  # 가용성 설정 (REGIONAL 또는 ZONAL)
    activation_policy            = optional(string, "ALWAYS") # 활성화 정책 (ALWAYS, NEVER, ON_DEMAND)
    disk_size                    = optional(number, 10)       # 디스크 크기 (GB 단위, 최소 10GB)
    disk_type                    = optional(string, "PD_SSD") # 디스크 유형 (PD_SSD 또는 PD_HDD)
    enable_google_ml_integration = optional(bool, false)      # Vertex AI 통합 활성화 여부

    advanced_machine_features = optional(object({
      threads_per_core = optional(number, null) # CPU 코어당 스레드 수
    }), null)

    database_flags = optional(list(object({
      name  = string # 데이터베이스 플래그 이름
      value = string # 데이터베이스 플래그 값
    })), [])

    active_directory_config = optional(object({
      domain = optional(string, null) # Active Directory 도메인 이름 (SQL Server 전용)
    }), null)

    deny_maintenance_period = optional(object({
      start_date = optional(string, null) # 유지보수 시작 날짜
      end_date   = optional(string, null) # 유지보수 종료 날짜
      time       = optional(string, null) # 유지보수 시간
    }), null)

    sql_server_audit_config = optional(object({
      bucket             = optional(string, null) # 감사 로그 저장 버킷
      upload_interval    = optional(string, null) # 업로드 주기
      retention_interval = optional(string, null) # 감사 로그 유지 기간
    }), null)

    backup_configuration = optional(object({
      enabled                        = bool                   # 백업 활성화 여부
      binary_log_enabled             = optional(bool, false)  # MySQL용 바이너리 로그 활성화 여부
      start_time                     = string                 # 백업 시작 시간 (HH:MM 형식)
      point_in_time_recovery_enabled = optional(bool, false)  # 시점 복구 활성화 여부
      location                       = optional(string, null) # 백업 저장 위치
    }), null)

    ip_configuration = optional(object({
      ipv4_enabled                                  = optional(bool, false)  # 공용 IPv4 활성화 여부
      private_network                               = optional(string, null) # Private IP에 연결할 VPC 네트워크
      ssl_mode                                      = optional(string, null) # SSL 모드 설정
      enable_private_path_for_google_cloud_services = optional(bool, false)  # Google Cloud 서비스의 Private Path 접근 허용 여부
      authorized_networks = optional(list(object({
        expiration_time = optional(string, null) # 허용 네트워크의 만료 시간
        name            = optional(string, null) # 허용 네트워크의 이름
        value           = string                 # 허용 네트워크의 CIDR
      })), [])
    }), null)

    maintenance_window = optional(object({
      day          = optional(number, null) # 유지보수 가능한 요일 (1-7, 월요일 시작)
      hour         = optional(number, null) # 유지보수 가능한 시간 (0-23)
      update_track = optional(string, null) # 업데이트 트랙 설정
    }), null)
  })
}

# 생성 제한 시간
variable "timeout_create" {
  description = "Cloud SQL 인스턴스 생성 작업의 시간 제한 (기본값: 30분)."
  type        = string
  default     = "90m"
}

# 업데이트 제한 시간
variable "timeout_update" {
  description = "Cloud SQL 인스턴스 업데이트 작업의 시간 제한 (기본값: 30분)."
  type        = string
  default     = "90m"
}

# 삭제 제한 시간
variable "timeout_delete" {
  description = "Cloud SQL 인스턴스 삭제 작업의 시간 제한 (기본값: 30분)."
  type        = string
  default     = "90m"
}