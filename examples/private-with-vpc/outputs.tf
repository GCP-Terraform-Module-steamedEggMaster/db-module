output "db_details" {
  description = "Cloud SQL 인스턴스 세부 정보"
  value = {
    id                      = module.db.id                          # Cloud SQL 인스턴스의 고유 ID
    name                    = module.db.name                        # Cloud SQL 인스턴스의 이름
    self_link               = module.db.self_link                   # Cloud SQL 인스턴스의 URI
    connection_name         = module.db.connection_name             # Cloud SQL 인스턴스의 연결 이름
    region                  = module.db.region                      # Cloud SQL 인스턴스가 위치한 리전
    project                 = module.db.project                     # Cloud SQL 인스턴스가 속한 프로젝트 ID
    database_version        = module.db.database_version            # 데이터베이스 버전
    tier                    = module.db.tier                        # 머신 타입
    disk_size               = module.db.disk_size                   # 디스크 크기 (GB)
    availability_type       = module.db.availability_type           # 고가용성 유형
    ip_addresses            = module.db.ip_addresses                # IP 주소 목록
    private_network         = module.db.private_network             # 프라이빗 네트워크
    ipv4_enabled            = module.db.ipv4_enabled                # IPv4 활성화 여부
    ssl_enforcement         = module.db.ssl_enforcement             # SSL 연결 정책
    backup_configuration    = module.db.backup_configuration        # 백업 설정
    query_insights          = module.db.query_insights              # Query Insights 설정
    maintenance_window      = module.db.maintenance_window          # 유지 관리 창
    labels                  = module.db.labels                      # 사용자 정의 레이블
    replica_names           = module.db.replica_names               # 복제본 이름 목록
    deletion_protection     = module.db.deletion_protection         # 삭제 보호 상태
  }
}
