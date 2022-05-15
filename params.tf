
# --== MYSQL ==-- #
data "aws_ssm_parameter" "mysql_password" {
  name = "isaiah-home.mysql_password"
}

# --== Keycloak ==-- #
data "aws_ssm_parameter" "keycloak_db_username" {
  name = "isaiah-home.keycloak_db_username"
}
data "aws_ssm_parameter" "keycloak_db_password" {
  name = "isaiah-home.keycloak_db_username"
}
data "aws_ssm_parameter" "keycloak_username" {
  name = "isaiah-home.keycloak_username"
}
data "aws_ssm_parameter" "keycloak_password" {
  name = "isaiah-home.keycloak_username"
}

