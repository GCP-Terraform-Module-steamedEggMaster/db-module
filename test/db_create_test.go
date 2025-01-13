package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestCreateDB(t *testing.T) {
	projectName := os.Getenv("GCP_PROJECT")

	// Terraform 옵션 설정
	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/private-with-vpc", // Terraform 루트 모듈 경로

		// Vars: map[string]interface{}{
		// 	"project": projectName,
		// },
	}

	// Terraform Init 및 Apply 실행
	defer terraform.Destroy(t, terraformOptions) // 테스트 종료 후 리소스 정리
	terraform.InitAndApply(t, terraformOptions)
}
