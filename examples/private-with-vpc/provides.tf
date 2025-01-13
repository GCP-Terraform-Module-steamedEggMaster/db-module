terraform {
  # 필수 제공자 설정
  required_providers {
    # Google 제공자의 소스와 버전을 지정합니다.
    google = {
      source = "hashicorp/google"
      version = "~> 4.0"
      # ~> : 틸다 연산자
      ## 주요 버전은 고정하고, 패치 버전은 최신으로 업데이트
    }
  }
}