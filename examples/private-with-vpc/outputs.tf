output "cloud_sql_details" {
  description = "Cloud SQL 인스턴스 세부 정보"
  value = {
    id                      = module.cloud_sql.id                          # Cloud SQL 인스턴스의 고유 ID
    name                    = module.cloud_sql.name                        # Cloud SQL 인스턴스의 이름
    self_link               = module.cloud_sql.self_link                   # Cloud SQL 인스턴스의 URI
    connection_name         = module.cloud_sql.connection_name             # Cloud SQL 인스턴스의 연결 이름
    region                  = module.cloud_sql.region                      # Cloud SQL 인스턴스가 위치한 리전
    project                 = module.cloud_sql.project                     # Cloud SQL 인스턴스가 속한 프로젝트 ID
    database_version        = module.cloud_sql.database_version            # 데이터베이스 버전
    tier                    = module.cloud_sql.tier                        # 머신 타입
    disk_size               = module.cloud_sql.disk_size                   # 디스크 크기 (GB)
    availability_type       = module.cloud_sql.availability_type           # 고가용성 유형
    ip_addresses            = module.cloud_sql.ip_addresses                # IP 주소 목록
    private_network         = module.cloud_sql.private_network             # 프라이빗 네트워크
    ipv4_enabled            = module.cloud_sql.ipv4_enabled                # IPv4 활성화 여부
    ssl_enforcement         = module.cloud_sql.ssl_enforcement             # SSL 연결 정책
    backup_configuration    = module.cloud_sql.backup_configuration        # 백업 설정
    query_insights          = module.cloud_sql.query_insights              # Query Insights 설정
    maintenance_window      = module.cloud_sql.maintenance_window          # 유지 관리 창
    labels                  = module.cloud_sql.labels                      # 사용자 정의 레이블
    replica_names           = module.cloud_sql.replica_names               # 복제본 이름 목록
    deletion_protection     = module.cloud_sql.deletion_protection         # 삭제 보호 상태
  }
}
