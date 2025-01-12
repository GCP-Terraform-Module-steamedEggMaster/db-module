# module "vpc" {
#   source = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/vpc-module.git?ref=v1.0.0"
# 
#   name = "test-private-vpc"
# }

module "database_instance" {
  source = "../../database-instance"

  name              = "test-sql-instance"
  database_version  = "POSTGRES_13"
  region            = "asia-northeast3"
  tier              = "db-f1-micro"
  disk_size         = 20
  disk_type         = "PD_SSD"
  activation_policy = "ALWAYS"
  availability_type = "REGIONAL"
  # ipv4_enabled      = false
  # private_network   = module.vpc.self_link
  user_labels       = { environment = "test" } # 사용자 정의 레이블
}

# Cloud SQL 인스턴스에 데이터베이스 정의
module "database" {
  source = "../../database"

  name            = "test-database"               # 데이터베이스 이름
  instance        = module.database_instance.name # 앞서 생성한 인스턴스 이름 참조
  charset         = "UTF8"                        # 문자 집합
  collation       = "en_US.UTF8"                  # 정렬 설정
  deletion_policy = "DELETE"                      # 삭제 정책 (DELETE 또는 ABANDON)
}

# Cloud SQL 데이터베이스 사용자 정의
module "database_user" {
  source = "../../database_user"

  instance = module.database_instance.name # 앞서 생성한 인스턴스 이름 참조
  name     = "test-user"                   # 사용자 이름
  password = "test-password"               # 사용자 비밀번호
  type     = "BUILT_IN"                    # 인증 유형 (BUILT_IN, CLOUD_IAM_USER 등)
  host     = "%"                           # 접속 허용 호스트 (%는 모든 호스트 허용)
}
