data "aws_ssm_parameter" "account_env" {
  provider = aws.parameters
  name     = "/account/environment"
}

data "aws_ssm_parameter" "base_vpc_id" {
  provider = aws.parameters
  name     = "/vpc/base/id"
}

data "aws_ssm_parameter" "my_public_ip" {
  provider = aws.parameters
  name     = "/account/owner/public/ip"
}

data "aws_ssm_parameter" "azure_application_id" {
  provider = aws.parameters
  name     = "/azure/application/id"
}

data "aws_ssm_parameter" "azure_tenant_id" {
  provider = aws.parameters
  name     = "/azure/tenant/id"
}

data "aws_ecrpublic_authorization_token" "token" {
  provider = aws.parameters
}

data "aws_availability_zones" "available" {}
