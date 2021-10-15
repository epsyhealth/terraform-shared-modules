data "aws_redshift_cluster" "general" {
  cluster_identifier = var.redshift_cluster_identifier
}

data "aws_secretsmanager_secret" "redshift_password" {
  name = "/aws/redshift/${var.redshift_cluster_identifier}/password"
}

data "aws_secretsmanager_secret_version" "redshift_password" {
  secret_id = data.aws_secretsmanager_secret.redshift_password.id
}

data "aws_subnet_ids" "redshift_subnets" {
  vpc_id = data.aws_redshift_cluster.general.vpc_id
}

resource "aws_glue_connection" "connection" {
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:redshift://${data.aws_redshift_cluster.general.endpoint}:5439/${var.connection_properties.database}"
    PASSWORD            = data.aws_secretsmanager_secret_version.redshift_password.secret_string
    USERNAME            = var.connection_properties.username
  }

  name = var.connection_name

  physical_connection_requirements {
    availability_zone      = var.physical_connection_requirements.availability_zone
    security_group_id_list = data.aws_redshift_cluster.general.vpc_security_group_ids
    subnet_id              = tolist(data.aws_subnet_ids.redshift_subnets.ids)[0]
  }
}
