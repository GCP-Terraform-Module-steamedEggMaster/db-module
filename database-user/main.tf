resource "google_sql_user" "user" {
  # 필수 옵션
  instance = var.instance # 연결된 Cloud SQL 인스턴스 이름
  name     = var.name     # 사용자 이름

  # 선택적 옵션
  password        = var.password        # 사용자 비밀번호
  type            = var.type            # 사용자 인증 유형 (SQL 또는 IAM, 기본값: SQL)
  deletion_policy = var.deletion_policy # 삭제 정책 (예: "ABANDON" 또는 "DELETE", 기본값: "DELETE")
  host            = var.host            # 사용자 접속 호스트 (기본값: '%', 모든 호스트 허용 / MySQL 전용)
  project         = var.project         # GCP 프로젝트 ID (지정하지 않으면 provider 기본값 사용)

  # 비밀번호 정책 (MySQL 전용)
  dynamic "password_policy" {
    for_each = var.password_policy != null ? [var.password_policy] : [] # 비밀번호 정책이 있을 경우에만 적용
    content {
      allowed_failed_attempts      = password_policy.value.allowed_failed_attempts      # 허용된 최대 로그인 실패 횟수 (MySQL 전용)
      password_expiration_duration = password_policy.value.password_expiration_duration # 비밀번호 만료 기간 (MySQL 전용, ISO 8601 형식)
      enable_failed_attempts_check = password_policy.value.enable_failed_attempts_check # 로그인 실패 체크 활성화 (MySQL 전용)
      enable_password_verification = password_policy.value.enable_password_verification # 비밀번호 변경 시 확인 활성화 (MySQL 전용)
    }
  }

  # 타임아웃 설정
  timeouts {
    create = var.timeout_create
    update = var.timeout_update
    delete = var.timeout_delete
  }
}