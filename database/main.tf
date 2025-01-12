resource "google_sql_database" "database" {
  # 필수 옵션
  name     = var.name     # 데이터베이스 이름
  instance = var.instance # Cloud SQL 인스턴스 이름

  # 선택적 옵션
  charset         = var.charset         # 문자 집합 (Optional)
  collation       = var.collation       # Collation 설정 (Optional)
  project         = var.project         # 프로젝트 ID (Optional)
  deletion_policy = var.deletion_policy # 삭제 정책 (Optional)

  timeouts {
    create = var.timeout_create # 생성 타임아웃
    update = var.timeout_update # 업데이트 타임아웃
    delete = var.timeout_delete # 삭제 타임아웃
  }
}