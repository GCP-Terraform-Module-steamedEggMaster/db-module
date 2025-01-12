# 필수 변수
variable "name" {
  description = "Cloud SQL 인스턴스 이름"
  type        = string
}

variable "database_version" {
  description = "Cloud SQL 데이터베이스 버전 (MYSQL_8_0, POSTGRES_14 등)"
  type        = string
}

variable "region" {
  description = "Cloud SQL 인스턴스가 생성될 리전"
  type        = string
}

# 설정 블록 변수
variable "tier" {
  description = "Cloud SQL 인스턴스 머신 타입"
  type        = string
}

variable "availability_type" {
  description = "Cloud SQL 인스턴스 고가용성 유형 (ZONAL 또는 REGIONAL)"
  type        = string
  default     = "ZONAL"
}

variable "disk_size" {
  description = "Cloud SQL 인스턴스 디스크 크기 (GB)"
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "Cloud SQL 인스턴스 디스크 유형 (PD_SSD 또는 PD_HDD)"
  type        = string
  default     = "PD_SSD"
}

variable "activation_policy" {
  description = "Cloud SQL 인스턴스 활성화 정책 (ALWAYS 또는 ON_DEMAND)"
  type        = string
  default     = "ALWAYS"
}

variable "collation" {
  description = "Cloud SQL 데이터베이스 콜레이션 설정"
  type        = string
  default     = null
}

# 백업 설정
variable "backup_enabled" {
  description = "백업 활성화 여부"
  type        = bool
  default     = true
}

variable "backup_start_time" {
  description = "백업 시작 시간 (HH:MM)"
  type        = string
  default     = "01:00"
}

variable "point_in_time_recovery_enabled" {
  description = "PITR (Point-in-time recovery) 활성화 여부"
  type        = bool
  default     = false
}

variable "binary_log_enabled" {
  description = "바이너리 로그 활성화 여부 (MySQL 전용)"
  type        = bool
  default     = false
}

variable "backup_location" {
  description = "백업 위치"
  type        = string
  default     = null
}

variable "transaction_log_retention_days" {
  description = "트랜잭션 로그 보존 일수"
  type        = number
  default     = null
}

# 디스크 자동 크기 조정 설정
variable "disk_autoresize" {
  description = "디스크 자동 크기 조정 활성화 여부"
  type        = bool
  default     = true
}

variable "disk_autoresize_limit" {
  description = "디스크 자동 크기 조정 제한 (GB)"
  type        = number
  default     = null
}

# IP 설정
variable "ipv4_enabled" {
  description = "IPv4 활성화 여부"
  type        = bool
  default     = true
}

variable "private_network" {
  description = "Cloud SQL 인스턴스에 연결할 프라이빗 네트워크"
  type        = string
  default     = null
}

variable "allocated_ip_range" {
  description = "Cloud SQL 인스턴스의 IP 범위"
  type        = string
  default     = null
}

variable "enable_private_path" {
  description = "Google Cloud 서비스와의 프라이빗 경로 활성화 여부"
  type        = bool
  default     = false
}

variable "ssl_mode" {
  description = "SSL 연결 설정 (ALLOW_UNENCRYPTED_AND_ENCRYPTED, ENCRYPTED_ONLY, TRUSTED_CLIENT_CERTIFICATE_REQUIRED)"
  type        = string
  default     = null
}

# 유지 관리 창 설정
variable "maintenance_day" {
  description = "유지 관리 요일 (1-7, 월요일 시작)"
  type        = number
  default     = null
}

variable "maintenance_hour" {
  description = "유지 관리 시작 시간 (0-23)"
  type        = number
  default     = null
}

variable "maintenance_update_track" {
  description = "유지 관리 업데이트 트랙 (stable 또는 canary)"
  type        = string
  default     = null
}

# Query Insights 설정
variable "query_insights_enabled" {
  description = "Query Insights 활성화 여부"
  type        = bool
  default     = false
}

variable "query_string_length" {
  description = "쿼리 문자열 최대 길이"
  type        = number
  default     = 1024
}

variable "record_application_tags" {
  description = "애플리케이션 태그 기록 여부"
  type        = bool
  default     = false
}

variable "record_client_address" {
  description = "클라이언트 주소 기록 여부"
  type        = bool
  default     = false
}

# 사용자 정의 레이블
variable "user_labels" {
  description = "사용자 정의 레이블 (key-value 형태)"
  type        = map(string)
  default     = {}
}

# 고급 머신 설정
variable "threads_per_core" {
  description = "코어당 스레드 수"
  type        = number
  default     = 2
}

# SQL Server 감사 설정
variable "audit_bucket" {
  description = "SQL Server 감사 로그를 저장할 버킷"
  type        = string
  default     = null
}

variable "audit_upload_interval" {
  description = "SQL Server 감사 로그 업로드 간격"
  type        = string
  default     = null
}

variable "audit_retention_interval" {
  description = "SQL Server 감사 로그 보존 기간"
  type        = string
  default     = null
}

# 비밀번호 정책 설정
variable "password_min_length" {
  description = "비밀번호 최소 길이"
  type        = number
  default     = null
}

variable "password_complexity" {
  description = "비밀번호 복잡성 설정"
  type        = string
  default     = null
}

variable "password_reuse_interval" {
  description = "비밀번호 재사용 금지 간격"
  type        = number
  default     = null
}

variable "password_disallow_username_substring" {
  description = "비밀번호에 사용자 이름 포함 금지 여부"
  type        = bool
  default     = null
}

variable "password_change_interval" {
  description = "비밀번호 변경 최소 간격"
  type        = number
  default     = null
}

variable "password_policy_enabled" {
  description = "비밀번호 정책 활성화 여부"
  type        = bool
  default     = false
}

# 삭제 보호
variable "deletion_protection" {
  description = "삭제 보호 활성화 여부"
  type        = bool
  default     = false
}

# 암호화 설정
variable "encryption_key_name" {
  description = "CMEK 암호화 키 이름"
  type        = string
  default     = null
}

# 복제 설정
variable "replica_failover_target" {
  description = "복제 대상의 Failover 설정 여부"
  type        = bool
  default     = false
}

variable "replica_username" {
  description = "복제 연결에 사용할 사용자 이름"
  type        = string
  default     = null
}

variable "replica_password" {
  description = "복제 연결에 사용할 비밀번호"
  type        = string
  default     = null
}

# 프로젝트 설정
variable "project" {
  description = "Cloud SQL 인스턴스가 속할 GCP 프로젝트 ID"
  type        = string
  default     = null
}