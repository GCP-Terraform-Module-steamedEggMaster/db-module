## ======================================================
## google_sql_user Variables
## ======================================================
variable "instance" {
  description = "Cloud SQL 인스턴스 이름"
  type        = string
}

variable "name" {
  description = "Cloud SQL 사용자 이름"
  type        = string
}

variable "password" {
  description = "Cloud SQL 사용자 비밀번호"
  type        = string
  default     = null
}

variable "type" {
  description = <<EOT
Cloud SQL 사용자 유형:
- BUILT_IN: 기본 데이터베이스 사용자
- CLOUD_IAM_USER: IAM 사용자 인증
- CLOUD_IAM_SERVICE_ACCOUNT: IAM 서비스 계정 인증
EOT
  type        = string
  default     = "BUILT_IN"
}

variable "deletion_policy" {
  description = <<EOT
사용자 삭제 정책:
- DELETE: 리소스 삭제
- ABANDON: 리소스를 삭제하지 않고 남김 (PostgreSQL용)
EOT
  type        = string
  default     = "DELETE"
}

variable "host" {
  description = "Cloud SQL 사용자 접속 호스트 (MySQL 전용)"
  type        = string
  default     = null
}

variable "project" {
  description = "Cloud SQL 리소스가 속할 GCP 프로젝트 ID"
  type        = string
  default     = null
}

variable "password_policy" {
  description = <<EOT
Cloud SQL 사용자 비밀번호 정책 (MySQL 전용):
- allowed_failed_attempts: 최대 허용된 로그인 실패 횟수
- password_expiration_duration: 비밀번호 만료 기간
- enable_failed_attempts_check: 로그인 실패 체크 활성화
- enable_password_verification: 비밀번호 변경 시 확인 활성화
EOT
  type = object({
    allowed_failed_attempts      = number
    password_expiration_duration = string
    enable_failed_attempts_check = bool
    enable_password_verification = bool
  })
  default = null
}

variable "timeout_create" {
  description = "사용자 생성 타임아웃"
  type        = string
  default     = "10m"
}

variable "timeout_update" {
  description = "사용자 업데이트 타임아웃"
  type        = string
  default     = "10m"
}

variable "timeout_delete" {
  description = "사용자 삭제 타임아웃"
  type        = string
  default     = "10m"
}