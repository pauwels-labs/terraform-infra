data "aws_rds_engine_version" "postgresql" {
  provider = aws.databases

  engine  = "aurora-postgresql"
  version = "15.3"
}

resource "aws_db_subnet_group" "private" {
  provider = aws.databases

  name        = "aurora-pgsql-private-${var.name}"
  subnet_ids  = [for subnet in aws_subnet.private : subnet.id]
  description = "Private subnet group for the ${var.name} Aurora Serverless v2 PostgreSQL cluster"

  tags = tomap({
    Name = "aurora-pgsql-private-${var.name}"
    Description = "Private subnet group for the ${var.name} Aurora Serverless v2 PostgreSQL cluster"
    Cluster = var.name
    Type = "private"
  })
}

resource "aws_db_parameter_group" "this" {
  provider = aws.databases

  name        = "aurora-pgsql-${var.name}"
  family      = "aurora-postgresql14"
  description = "Parameter group for the ${var.name} Aurora Serverless v2 PostgreSQL database"
  tags        = tomap({
    Name        = "aurora-pgsql-${var.name}"
    Description = "Parameter group for the ${var.name} Aurora Serverless v2 PostgreSQL database"
    Cluster     = var.name
    Type        = "database"
  })
}

resource "aws_rds_cluster_parameter_group" "this" {
  provider = aws.databases

  name        = "aurora-pgsql-${var.name}"
  family      = "aurora-postgresql14"
  description = "Parameter group for the ${var.name} Aurora Serverless v2 PostgreSQL cluster"
  tags        = tomap({
    Name        = "aurora-pgsql-${var.name}"
    Description = "Parameter group for the ${var.name} Aurora Serverless v2 PostgreSQL cluster"
    Cluster     = var.name
    Type        = "cluster"
  })
}

resource "aws_db_parameter_group" "this_v15" {
  provider = aws.databases

  name        = "aurora-pgsql-${var.name}-v15"
  family      = "aurora-postgresql15"
  description = "Parameter group for the ${var.name} Aurora Serverless v2 PostgreSQL database"
  tags        = tomap({
    Name         = "aurora-pgsql-${var.name}-v15"
    Description  = "Parameter group for the ${var.name} Aurora Serverless v2 PostgreSQL database"
    Cluster      = var.name
    Type         = "database"
    MajorVersion = "15"
  })
}

resource "aws_rds_cluster_parameter_group" "this_v15" {
  provider = aws.databases

  name        = "aurora-pgsql-${var.name}-v15"
  family      = "aurora-postgresql15"
  description = "Parameter group for the ${var.name} Aurora Serverless v2 PostgreSQL cluster"
  tags        = tomap({
    Name         = "aurora-pgsql-${var.name}-v15"
    Description  = "Parameter group for the ${var.name} Aurora Serverless v2 PostgreSQL cluster"
    Cluster      = var.name
    Type         = "cluster"
    MajorVersion = "15"
  })
}

resource "aws_secretsmanager_secret" "master_username" {
  provider = aws.databases

  name        = "aurora-pgsql-master-username-${var.name}"
  description = "Username for the master account of the ${var.name} Aurora Serverless v2 PostgreSQL database"
  kms_key_id  = aws_kms_alias.master_credentials.arn

  # TODO: Add recovery days
  recovery_window_in_days = 0

  tags        = tomap({
    Name        = "aurora-pgsql-master-username-${var.name}"
    Description = "Username for the master account of the ${var.name} Aurora Serverless v2 PostgreSQL database"
    Cluster     = var.name
    Type        = "username"
  })
}

resource "aws_secretsmanager_secret_version" "master_username" {
  provider = aws.databases

  secret_id     = aws_secretsmanager_secret.master_username.id
  secret_string = "root"
}

resource "aws_secretsmanager_secret" "master_password" {
  provider = aws.databases

  name        = "aurora-pgsql-master-password-${var.name}"
  description = "Password for the master account of the ${var.name} Aurora Serverless v2 PostgreSQL database"
  kms_key_id  = aws_kms_alias.master_credentials.arn

  # TODO: Add recovery days
  recovery_window_in_days = 0

  tags        = tomap({
    Name        = "aurora-pgsql-master-username-${var.name}"
    Description = "Password for the master account of the ${var.name} Aurora Serverless v2 PostgreSQL database"
    Cluster     = var.name
    Type        = "password"
  })
}

resource "random_password" "master" {
  length      = 16
  min_lower   = 1
  min_numeric = 1
  min_special = 1
  min_upper   = 1
}

resource "aws_secretsmanager_secret_version" "master_password" {
  provider = aws.databases

  secret_id     = aws_secretsmanager_secret.master_password.id
  secret_string = random_password.master.result
}

module "this" {
  source    = "terraform-aws-modules/rds-aurora/aws"
  version   = "7.5.1"
  providers = {
    aws = aws.databases
  }

  name              = var.name
  engine            = data.aws_rds_engine_version.postgresql.engine
  engine_mode       = "provisioned"
  engine_version    = data.aws_rds_engine_version.postgresql.version

  allow_major_version_upgrade                 = true
  db_cluster_db_instance_parameter_group_name = aws_db_parameter_group.this_v15.id

  storage_encrypted = true
  kms_key_id        = aws_kms_key.this.arn

  vpc_id        = aws_vpc.this.id
  subnets       = [for subnet in aws_subnet.private : subnet.id]
  database_name = var.name
  network_type  = "DUAL"

  create_security_group = true
  allowed_cidr_blocks   = [for subnet in aws_subnet.private : subnet.cidr_block]
  publicly_accessible    = false

  # TODO: Turn on monitoring by setting this > 0 minutes
  monitoring_interval = 0
  # TODO: Flip this to false
  apply_immediately   = true
  # TODO: Flip this to false
  skip_final_snapshot = true

  create_db_cluster_parameter_group = false
  db_cluster_parameter_group_name   = aws_rds_cluster_parameter_group.this_v15.id

  create_db_parameter_group = false
  db_parameter_group_name   = aws_db_parameter_group.this_v15.id

  create_db_subnet_group = false
  db_subnet_group_name   = aws_db_subnet_group.private.name

  create_random_password = false
  master_username = aws_secretsmanager_secret_version.master_username.secret_string
  master_password = random_password.master.result

  create_monitoring_role = true

  serverlessv2_scaling_configuration = {
    min_capacity = 0.5
    max_capacity = 1.0
  }

  instance_class = "db.serverless"
  instances      = {
    primary = {}
  }
}
