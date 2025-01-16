# db-module
GCP Terraform Database Module Repo

GCP에서 Cloud SQL 인스턴스와 데이터베이스를 관리하기 위한 Terraform 모듈입니다. <br> 
이 모듈은 Cloud SQL 인스턴스 및 사용자, 데이터베이스를 쉽게 설정할 수 있도록 설계되었습니다.

<br>

## 📑 **목차**
1. [모듈 특징](#모듈-특징)
2. [사용 방법](#사용-방법)
    1. [사전 준비](#1-사전-준비)
    2. [입력 변수](#2-입력-변수)
    3. [모듈 호출 예시](#3-모듈-호출-예시)
    4. [출력값 (Outputs)](#4-출력값-outputs)
    5. [지원 버전](#5-지원-버전)
    6. [모듈 구조](#6-모듈-구조)
3. [테스트](#테스트)
4. [기여](#기여-contributing)
5. [라이선스](#라이선스-license)

---

## 모듈 특징

- Cloud SQL 인스턴스 생성 및 관리.
- 데이터베이스 및 사용자 생성 지원.
- 사용자 비밀번호 정책 및 조건 설정 가능 (MySQL 전용).
- 다양한 데이터베이스 버전 지원 (MySQL, PostgreSQL 등).
- 주요 리소스의 속성 출력.

---

## 사용 방법

### 1. 사전 준비

다음 사항을 확인하세요:
1. Google Cloud 프로젝트 준비.
2. 적절한 IAM 권한 필요: `roles/cloudsql.admin`.

### 2. 입력 변수

#### 1. `database-instance`

| 변수명                 | 타입      | 필수 여부 | 기본값 | 설명                                                                 |
|------------------------|-----------|-----------|--------|----------------------------------------------------------------------|
| `name`                | string    | ✅        | 없음   | Cloud SQL 인스턴스 이름                                               |
| `region`              | string    | ✅        | 없음   | Cloud SQL 인스턴스 리전 (예: `us-central1`)                          |
| `database_version`    | string    | ✅        | 없음   | Cloud SQL 데이터베이스 버전 (예: `MYSQL_5_7`, `POSTGRES_13`)          |
| `deletion_protection` | bool      | ❌        | `false`| 인스턴스 삭제 보호 여부                                              |
| `project`             | string    | ❌        | 없음   | GCP 프로젝트 ID                                                     |
| `root_password`       | string    | ❌        | `null` | Cloud SQL 초기 루트 사용자 비밀번호                                   |
| `settings`            | object    | ✅        | 없음   | Cloud SQL 인스턴스 설정 (머신 유형, 디스크 크기 등)                   |
| `timeout_create`      | string    | ❌        | `90m`  | 생성 작업의 시간 제한                                                |
| `timeout_update`      | string    | ❌        | `90m`  | 업데이트 작업의 시간 제한                                            |
| `timeout_delete`      | string    | ❌        | `90m`  | 삭제 작업의 시간 제한                                                |

#### 1-1. `settings` 객체 필드
| 필드명                     | 타입      | 필수 여부 | 설명                                                             |
|----------------------------|-----------|-----------|-----------------------------------------------------------------|
| `tier`                    | string    | ✅        | 머신 유형 (예: `db-n1-standard-1`)                               |
| `availability_type`       | string    | ❌        | 가용성 설정 (`ZONAL`, `REGIONAL`, 기본값: `ZONAL`)               |
| `activation_policy`       | string    | ❌        | 활성화 정책 (`ALWAYS`, `NEVER`, 기본값: `ALWAYS`)                |
| `disk_size`               | number    | ❌        | 디스크 크기 (GB, 기본값: 10)                                     |
| `disk_type`               | string    | ❌        | 디스크 유형 (`PD_SSD`, `PD_HDD`, 기본값: `PD_SSD`)               |
| `enable_google_ml_integration` | bool | ❌        | Vertex AI 통합 활성화 여부 (기본값: `false`)                     |
| `backup_configuration`    | object    | ❌        | 백업 설정 (활성화 여부, 시작 시간, 시점 복구 여부 등)            |
| `ip_configuration`        | object    | ❌        | IP 설정 (IPv4 활성화 여부, Private Network 설정 등)               |
| `maintenance_window`      | object    | ❌        | 유지 관리 창 설정 (요일, 시간 등)                                 |

#### 2. `database`

| 변수명                 | 타입      | 필수 여부 | 기본값 | 설명                                                                 |
|------------------------|-----------|-----------|--------|----------------------------------------------------------------------|
| `name`                | string    | ✅        | 없음   | Cloud SQL 데이터베이스 이름                                           |
| `instance`            | string    | ✅        | 없음   | Cloud SQL 인스턴스 이름                                              |
| `charset`             | string    | ❌        | `null` | 데이터베이스 문자셋 (예: `UTF8`)                                      |
| `collation`           | string    | ❌        | `null` | 데이터베이스 정렬 방식 (예: `en_US.UTF8`)                             |
| `project`             | string    | ❌        | `null` | GCP 프로젝트 ID                                                      |
| `deletion_policy`     | string    | ❌        | `DELETE`| 데이터베이스 삭제 정책 (예: `DELETE`, `ABANDON`)                      |
| `timeout_create`      | string    | ❌        | `20m`  | 생성 작업의 시간 제한                                                |
| `timeout_update`      | string    | ❌        | `20m`  | 업데이트 작업의 시간 제한                                            |
| `timeout_delete`      | string    | ❌        | `20m`  | 삭제 작업의 시간 제한                                                |

#### 3. `database-user`

| 변수명                 | 타입      | 필수 여부 | 기본값  | 설명                                                                 |
|------------------------|-----------|-----------|---------|----------------------------------------------------------------------|
| `instance`            | string    | ✅        | 없음    | Cloud SQL 인스턴스 이름                                              |
| `name`                | string    | ✅        | 없음    | 사용자 이름                                                         |
| `password`            | string    | ❌        | `null`  | 사용자 비밀번호                                                     |
| `type`                | string    | ❌        | `BUILT_IN`| 사용자 유형 (`BUILT_IN`, `CLOUD_IAM_USER`, `CLOUD_IAM_SERVICE_ACCOUNT`)|
| `deletion_policy`     | string    | ❌        | `""`    | 삭제 정책 (`DELETE`, `ABANDON`)                                      |
| `host`                | string    | ❌        | `null`  | 사용자 접속 호스트 (MySQL 전용)                                      |
| `project`             | string    | ❌        | `null`  | GCP 프로젝트 ID                                                     |
| `password_policy`     | object    | ❌        | `null`  | 비밀번호 정책 설정 (MySQL 전용)                                      |
| `timeout_create`      | string    | ❌        | `10m`   | 생성 작업의 시간 제한                                                |
| `timeout_update`      | string    | ❌        | `10m`   | 업데이트 작업의 시간 제한                                            |
| `timeout_delete`      | string    | ❌        | `10m`   | 삭제 작업의 시간 제한                                                |

#### 3-1. `password_policy` 객체 필드
| 필드명                     | 타입      | 필수 여부 | 설명                                                                 |
|----------------------------|-----------|-----------|----------------------------------------------------------------------|
| `allowed_failed_attempts` | number    | ❌        | 허용된 최대 로그인 실패 횟수 (MySQL 전용)                             |
| `password_expiration_duration` | string | ❌        | 비밀번호 만료 기간 (ISO 8601 형식, MySQL 전용)                        |
| `enable_failed_attempts_check` | bool   | ❌        | 로그인 실패 체크 활성화 (MySQL 전용)                                  |
| `enable_password_verification` | bool   | ❌        | 비밀번호 변경 시 확인 활성화 (MySQL 전용)                             |

<br>

### 3. 모듈 호출 예시

```hcl
module "cloud_sql_instance" {
  source = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/db-module.git//database-instance?ref=v1.0.0"

  name               = "my-cloud-sql-instance"
  region             = "us-central1"
  database_version   = "POSTGRES_13"
  project            = "my-project-id"
  root_password      = "secure-instance-password"
  deletion_protection = false

  settings = {
    tier                   = "db-n1-standard-1"
    disk_size              = 20
    availability_type      = "ZONAL"
    enable_google_ml_integration = false

    backup_configuration = {
      enabled = true
      start_time = "23:00"
    }

    ip_configuration = {
      ipv4_enabled    = true
      private_network = "my-vpc-network"
      authorized_networks = [
        {
          name  = "my-network"
          value = "192.168.0.0/24"
        }
      ]
    }
  }

  timeout_create = "30m"
  timeout_update = "30m"
  timeout_delete = "30m"
}

module "cloud_sql_database" {
  source = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/db-module.git//database?ref=v1.0.0"

  name            = "my-database"
  instance        = module.cloud_sql_instance.name
  charset         = "UTF8"
  collation       = "en_US.UTF8"
  project         = "my-project-id"
  deletion_policy = "ABANDON"

  timeout_create = "20m"
  timeout_update = "20m"
  timeout_delete = "20m"
}

module "cloud_sql_user" {
  source = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/db-module.git//database-user?ref=v1.0.0"

  instance        = module.cloud_sql_instance.name
  name            = "my-user"
  password        = "secure-user-password"
  type            = "BUILT_IN"
  deletion_policy = "ABANDON"
  host            = "%"
  project         = "my-project-id"

  password_policy = {
    allowed_failed_attempts      = 5
    password_expiration_duration = "30d"
    enable_failed_attempts_check = true
    enable_password_verification = true
  }

  timeout_create = "15m"
  timeout_update = "15m"
  timeout_delete = "15m"
}
```

<br>

### 4. 출력값 (Outputs)

#### 1. `database-instance`

| 출력명                   | 설명                                                                 |
|--------------------------|----------------------------------------------------------------------|
| `id`                    | Cloud SQL 인스턴스의 고유 ID                                          |
| `name`                  | Cloud SQL 인스턴스의 이름                                             |
| `self_link`             | Cloud SQL 인스턴스의 URI                                              |
| `connection_name`       | Cloud SQL 인스턴스의 연결 이름                                        |
| `region`                | Cloud SQL 인스턴스가 위치한 GCP 리전                                  |
| `project`               | Cloud SQL 인스턴스가 속한 GCP 프로젝트 ID                             |
| `database_version`      | Cloud SQL 인스턴스의 데이터베이스 버전                                 |
| `tier`                  | Cloud SQL 인스턴스의 머신 타입                                        |
| `disk_size`             | Cloud SQL 인스턴스의 디스크 크기 (GB)                                  |
| `availability_type`     | Cloud SQL 인스턴스의 고가용성 유형                                     |
| `ip_addresses`          | Cloud SQL 인스턴스의 IP 주소 목록                                     |
| `private_network`       | Cloud SQL 인스턴스가 연결된 프라이빗 네트워크                          |
| `ipv4_enabled`          | Cloud SQL 인스턴스의 IPv4 활성화 여부                                 |
| `backup_configuration`  | Cloud SQL 인스턴스의 백업 설정 (활성화 여부, 시작 시간, 복구 여부 등)   |
| `query_insights`        | Cloud SQL 인스턴스의 Query Insights 설정                               |
| `maintenance_window`    | Cloud SQL 인스턴스의 유지 관리 창 설정                                 |
| `labels`                | Cloud SQL 인스턴스의 사용자 정의 레이블                                |
| `deletion_protection`   | Cloud SQL 인스턴스의 삭제 보호 상태                                    |

#### 2. `database`

| 출력명      | 설명                                                               |
|-------------|--------------------------------------------------------------------|
| `id`        | Cloud SQL 데이터베이스의 고유 ID (Terraform 리소스 식별자)          |
| `name`      | Cloud SQL 데이터베이스 이름                                        |
| `instance`  | Cloud SQL 데이터베이스가 연결된 Cloud SQL 인스턴스 이름             |
| `project`   | Cloud SQL 데이터베이스가 속한 GCP 프로젝트 ID                       |
| `charset`   | Cloud SQL 데이터베이스에 설정된 문자셋 (예: UTF8)                   |
| `collation` | Cloud SQL 데이터베이스에 설정된 Collation                          |
