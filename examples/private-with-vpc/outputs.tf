output "database_instance_details" {
  description = "Cloud SQL 인스턴스 세부 정보"
  value = {
    id                   = module.test_instance.id                   # Cloud SQL 인스턴스의 고유 ID
    name                 = module.test_instance.name                 # Cloud SQL 인스턴스의 이름
    self_link            = module.test_instance.self_link            # Cloud SQL 인스턴스의 URI
    connection_name      = module.test_instance.connection_name      # Cloud SQL 인스턴스의 연결 이름
    region               = module.test_instance.region               # Cloud SQL 인스턴스가 위치한 리전
    project              = module.test_instance.project              # Cloud SQL 인스턴스가 속한 프로젝트 ID
    database_version     = module.test_instance.database_version     # 데이터베이스 버전
    tier                 = module.test_instance.tier                 # 머신 타입
    disk_size            = module.test_instance.disk_size            # 디스크 크기 (GB)
    availability_type    = module.test_instance.availability_type    # 고가용성 유형
    ip_addresses         = module.test_instance.ip_addresses         # IP 주소 목록
    private_network      = module.test_instance.private_network      # 프라이빗 네트워크
    ipv4_enabled         = module.test_instance.ipv4_enabled         # IPv4 활성화 여부
    backup_configuration = module.test_instance.backup_configuration # 백업 설정
    query_insights       = module.test_instance.query_insights       # Query Insights 설정
    maintenance_window   = module.test_instance.maintenance_window   # 유지 관리 창
    labels               = module.test_instance.labels               # 사용자 정의 레이블       # 복제본 이름 목록
    deletion_protection  = module.test_instance.deletion_protection  # 삭제 보호 상태
  }
}
