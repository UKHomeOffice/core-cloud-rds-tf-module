variable "instances" {
  description = "A map of RDS instance configurations."
  type = map(object({
    allowed_cidr_blocks         = optional(list(string), [])
    allocated_storage           = number
    backup_retention_period     = number
    backup_window               = string
    database_name               = string
    database_user               = string
    deletion_protection         = bool
    engine                      = string
    engine_version              = string
    environment                 = string
    final_snapshot_identifier   = optional(string, null)
    instance_class              = string
    maintenance_window          = string
    manage_master_user_password = optional(bool, null)
    multi_az                    = optional(bool, false)
    name                        = string
    project_name                = string
    secret_name                 = optional(string, null)
    skip_final_snapshot         = bool
    snapshot_identifier         = optional(string)
    storage_type                = string
    storage_encrypted           = bool
  }))
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group to use."
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Determines whether RDS instance uses multi-az"
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "Specifies whether the RDS instance storage is encrypted"
  type        = bool
  default     = true
  nullable    = false

  validation {
    condition     = contains(["true"], var.storage_encrypted)
    error_message = "storage_encrypted must be true."
  }
}

variable "manage_master_user_password" {
  description = "Determines whether AWS should manage the master user password"
  type        = bool
  default     = false
}

#variable "secret_name" {
#  description = "Name of the secret in AWS Secrets Manager that contains the RDS password"
#  type        = string
#  default     = null
#}

variable "kms_key_arn" {
  description = "Optional KMS key ARN to encrypt the RDS and Secrets Manager secrets"
  type        = string
  default     = null
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where RDS instance will be created"
  type        = string
}

variable "tags" {
  type = object({
    cost-centre      = string
    account-code     = string
    portfolio-id     = string
    project-id       = string
    service-id       = string
    environment-type = string
    owner-business   = string
    budget-holder    = string
    hosting-platform = string
  })
  description = "The following tags must be applied to all resources: cost-centre, account-code, portfolio-id, project-id, service-id, environment-type, owner-business, budget-holder and hosting-platform"
  nullable    = false
}

variable "security_group_ids" {
  description = "A map of existing security group IDs to use for the instances, keyed by the instance name. If not provided, new ones will be created."
  type        = map(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of additional VPC security group IDs."
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the DB Subnet Group."
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "A list of CIDR blocks to allow ingress traffic from for newly created security groups."
  type        = list(string)
  default     = []
}
