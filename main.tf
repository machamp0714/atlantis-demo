module "atlantis" {
  source  = "terraform-aws-modules/atlantis/aws"
  version = "~> 3.0"

  name = "atlantis"

  # VPC
  cidr            = "10.20.0.0/16"
  azs             = ["ap-northeast-1a", "ap-northeast-1d"]
  private_subnets = ["10.20.1.0/24", "10.20.2.0/24"]
  public_subnets  = ["10.20.101.0/24", "10.20.102.0/24"]

  # DNS
  route53_zone_name = "machamp.blog"

  # Atlantis
  atlantis_repo_allowlist        = ["github.com/machamp0714/atlantis-demo"]
  atlantis_github_app_id         = var.atlantis_github_app_id
  atlantis_github_app_key        = file("./github_app_key.pem")
  atlantis_github_webhook_secret = var.atlantis_github_webhook_secret

  # ECS
  ecs_fargate_spot = true

  user = "100:1000"

  enable_ephemeral_storage = true
}

resource "aws_ssm_parameter" "foo" {
  name  = "foo"
  type  = "String"
  value = "bar"
}
