# --== SMTP ==-- #
data "aws_ssm_parameter" "smtp_host" {
  name = "organize-me.smtp_host"
}
data "aws_ssm_parameter" "smtp_port" {
  name = "organize-me.smtp_port"
}
data "aws_ssm_parameter" "smtp_username" {
  name = "organize-me.smtp_username"
}
data "aws_ssm_parameter" "smtp_password" {
  name = "organize-me.smtp_password"
}

# --== MYSQL ==-- #
data "aws_ssm_parameter" "mysql_password" {
  name = "organize-me.mysql_password"
}

# --== Keycloak ==-- #
data "aws_ssm_parameter" "keycloak_db_username" {
  name = "organize-me.keycloak_db_username"
}
data "aws_ssm_parameter" "keycloak_db_password" {
  name = "organize-me.keycloak_db_password"
}
data "aws_ssm_parameter" "keycloak_username" {
  name = "organize-me.keycloak_username"
}
data "aws_ssm_parameter" "keycloak_password" {
  name = "organize-me.keycloak_password"
}

# --== WikiJs ==-- #
data "aws_ssm_parameter" "wikijs_db_username" {
  name = "organize-me.wikijs_db_username"
}
data "aws_ssm_parameter" "wikijs_db_password" {
  name = "organize-me.wikijs_db_password"
}

# --== Nextcloud ==-- #
data "aws_ssm_parameter" "nextcloud_db_username" {
  name = "organize-me.nextcloud_db_username"
}
data "aws_ssm_parameter" "nextcloud_db_password" {
  name = "organize-me.nextcloud_db_password"
}
data "aws_ssm_parameter" "nextcloud_username" {
  name = "organize-me.nextcloud_username"
}
data "aws_ssm_parameter" "nextcloud_password" {
  name = "organize-me.nextcloud_password"
}

# --== Snipe-IT ==-- #
data "aws_ssm_parameter" "snipeit_db_username" {
  name = "organize-me.snipeit_db_username"
}
data "aws_ssm_parameter" "snipeit_db_password" {
  name = "organize-me.snipeit_db_password"
}
data "aws_ssm_parameter" "snipeit_appkey" {
  name = "organize-me.snipeit_appkey"
}
