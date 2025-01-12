## ======================================================
## google_sql_database Variables
## ======================================================
variable "name" {
  description = "Cloud SQL 데이터베이스의 이름"
  type        = string
}

variable "instance" {
  description = "Cloud SQL 인스턴스 이름"
  type        = string
}

variable "charset" {
  description = "데이터베이스 문자셋 (예: UTF8)"
  type        = string
  default     = null
}

variable "collation" {
  description = "데이터베이스 정렬 방식 (예: en_US.UTF8)"
  type        = string
  default     = null
}

variable "project" {
  description = "Cloud SQL 데이터베이스가 속할 GCP 프로젝트 ID"
  type        = string
  default     = null
}

variable "deletion_policy" {
  description = <<EOT
데이터베이스 삭제 정책. 
- DELETE: 리소스 삭제
- ABANDON: 리소스를 삭제하지 않고 남김 (PostgreSQL용)
EOT
  type        = string
  default     = "DELETE"
}

variable "timeout_create" {
  description = "Cloud SQL 데이터베이스 생성 타임아웃"
  type        = string
  default     = "20m"
}

variable "timeout_update" {
  description = "Cloud SQL 데이터베이스 업데이트 타임아웃"
  type        = string
  default     = "20m"
}

variable "timeout_delete" {
  description = "Cloud SQL 데이터베이스 삭제 타임아웃"
  type        = string
  default     = "20m"
}