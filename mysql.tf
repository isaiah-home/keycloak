provider "mysql" {
  endpoint = "localhost:3306"
  username = "root"
  password = data.aws_ssm_parameter.mysql_password.value
}

resource "docker_image" "mysql" {
  name         = "mysql:8.0"
  keep_locally = true
}

resource "docker_container" "mysql" {
  image    = docker_image.mysql.latest
  name     = "organize-me-mysql"
  hostname = "mysql"
  restart  = "unless-stopped"
  env   = [
    "MYSQL_ROOT_PASSWORD=${data.aws_ssm_parameter.mysql_password.value}"
  ]
  networks_advanced {
    name    = docker_network.organize_me_network.name
    ipv4_address = "172.22.0.2"
    aliases = ["mysql"]
  }
  ports {
    internal = 3306
    external = 3306
  }
}
