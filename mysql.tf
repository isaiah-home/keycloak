provider "mysql" {
  endpoint = "localhost:3306"
  username = "root"
  password = var.mysql_password
}

resource "docker_image" "mysql" {
  name         = "mysql:8.0"
  keep_locally = true
}

resource "docker_container" "mysql" {
  image    = docker_image.mysql.latest
  name     = "mysql"
  hostname = "mysql"
  env   = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_password}"
  ]
  networks_advanced {
    name    = docker_network.home_network.name
    ipv4_address = "172.22.0.2"
    aliases = ["mysql"]
  }
  ports {
    internal = 3306
    external = 3306
  }
}
