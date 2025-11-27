## Core Cloud RDS Module

This RDS Module is written and maintained by the Core Cloud Platform team and includes the following checks and scans:
Terraform validate, Terraform fmt, Checkov scan, Sonarqube scan, Semantic versioning - MAJOR.MINOR.PATCH.

## Usage

See the below example configuration:

```
terraform {
  source = "https://github.com/UKHomeOffice/core-cloud-rds-tf-module.git?ref={tag}"
}

inputs = {
  vpc_id               = "xxx"
  subnet_ids           = ["xxx"]
  project_name         = "test-project"
  environment          = "test"
  db_subnet_group_name = "test-group"

  # RDS Instances Configuration
  instances = {
    test = {
      allocated_storage           = 10
      backup_retention_period     = 7
      backup_window               = "22:00-03:00"
      database_name               = "test"
      database_user               = "test"
      deletion_protection         = true
      engine                      = "xxx"
      engine_version              = "xxx"
      environment                 = "test"
      instance_class              = "db.t4g.micro"
      manage_master_user_password = false
      maintenance_window          = "Mon:04:00-Mon:05:00"
      name                        = "test"
      project_name                = "test-project"
      skip_final_snapshot         = false
      storage_type                = "gp3"
      storage_encrypted           = true
    }
  }

  # Tags for all resources
  tags = {
    cost-centre      = "xxx"
    account-code     = "xxx"
    portfolio-id     = "xxx"
    project-id       = "xxx"
    service-id       = "xxx"
    environment-type = "xxx"
    owner-business   = "xxx"
    budget-holder    = "xxx"
    hosting-platform = "xxx"
  }
}

Note: secret_name must be provided as a parameter if manage_master_user_password = true and should not be provided if manage_master_user_password = false
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.88.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.88.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.custom_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance.managed_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_secretsmanager_secret.rds_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.rds_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_password.rds](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_db_subnet_group.existing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_subnet_group) | data source |
| [aws_security_group.existing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | A list of CIDR blocks to allow ingress traffic from for newly created security groups. | `list(string)` | `[]` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | The name of the DB subnet group to use. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (e.g., dev, staging, prod) | `string` | n/a | yes |
| <a name="input_instances"></a> [instances](#input\_instances) | A map of RDS instance configurations. | <pre>map(object({<br/>    allowed_cidr_blocks         = optional(list(string), [])<br/>    allocated_storage           = number<br/>    backup_retention_period     = number<br/>    backup_window               = string<br/>    database_name               = string<br/>    database_user               = string<br/>    deletion_protection         = bool<br/>    engine                      = string<br/>    engine_version              = string<br/>    environment                 = string<br/>    final_snapshot_identifier   = optional(string, null)<br/>    instance_class              = string<br/>    maintenance_window          = string<br/>    manage_master_user_password = optional(bool, null)<br/>    multi_az                    = optional(bool, false)<br/>    name                        = string<br/>    project_name                = string<br/>    secret_name                 = optional(string, null)<br/>    skip_final_snapshot         = bool<br/>    snapshot_identifier         = optional(string)<br/>    storage_type                = string<br/>    storage_encrypted           = bool<br/>  }))</pre> | n/a | yes |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Optional KMS key ARN to encrypt the RDS and Secrets Manager secrets | `string` | `null` | no |
| <a name="input_manage_master_user_password"></a> [manage\_master\_user\_password](#input\_manage\_master\_user\_password) | Determines whether AWS should manage the master user password | `bool` | `false` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Determines whether RDS instance uses multi-az | `bool` | `false` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A map of existing security group IDs to use for the instances, keyed by the instance name. If not provided, new ones will be created. | `map(string)` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs for the DB Subnet Group. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the RDS resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where RDS instance will be created | `string` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | A list of additional VPC security group IDs. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | A map of connection endpoints for all RDS instances |
| <a name="output_instance_ids"></a> [instance\_ids](#output\_instance\_ids) | A map of RDS instance IDs |
| <a name="output_rds_instance_ids"></a> [rds\_instance\_ids](#output\_rds\_instance\_ids) | A map of RDS instance IDs |
| <a name="output_rds_password_secrets"></a> [rds\_password\_secrets](#output\_rds\_password\_secrets) | A map of Secrets Manager ARNs for RDS passwords (only if AWS is NOT managing passwords) |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | n/a |
