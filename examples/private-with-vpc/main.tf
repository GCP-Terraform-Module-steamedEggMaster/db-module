module "vpc" {
  source = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/vpc-module.git?ref=v1.0.0"
  
  name = "test-private-vpc"
}

module "db" {
  source = "../../"

  name              = "test-sql-instance"
  database_version  = "POSTGRES_13"
  region            = "asia-northeast1"
  tier              = "db-custom-2-8192"
  availability_type = "REGIONAL"
  disk_size         = 20
  activation_policy = "ALWAYS"
  ipv4_enabled      = true
  private_network   = module.vpc.id
  user_labels       = { environment = "test" }
}