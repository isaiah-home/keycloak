provider "mysql" {
  endpoint = "localhost:3306"
  username = "root"
  password = data.aws_ssm_parameter.mysql_password.value
}

