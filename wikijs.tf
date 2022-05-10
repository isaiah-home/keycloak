resource "mysql_database" "wikijs" {
  default_character_set = "utf8mb3"
  name                  = "wikijs"
  depends_on = [docker_container.mysql]
}

resource "mysql_user" "wikijs" {
  user               = "${var.db_wikijs_username}"
  host               = "172.22.0.4"
  plaintext_password = "${var.db_wikijs_password}"
  depends_on = [docker_container.mysql]
}

resource "mysql_grant" "wikijs" {
  user = "${mysql_user.wikijs.user}"
  host = "${mysql_user.wikijs.host}"
  database = "${mysql_database.wikijs.name}"
  privileges = ["ALL PRIVILEGES"]
  depends_on = [mysql_user.wikijs, mysql_database.wikijs]
}

resource "docker_image" "wikijs" {
  name         = "ghcr.io/requarks/wiki:2"
  keep_locally = true
}

resource "docker_container" "wikijs" {
  image         = docker_image.wikijs.latest
  name          = "wikijs"
  hostname      = "wikijs"
  env   = [
    "DB_TYPE=mysql",
    "DB_HOST=mysql",
    "DB_PORT=3306",
    "DB_USER=${var.db_wikijs_username}",
    "DB_PASS=${var.db_wikijs_password}",
    "DB_NAME=wikijs"
  ]
  networks_advanced {
    name    = docker_network.home_network.name
    aliases = ["wikijs"]
    ipv4_address = "172.22.0.4"
  }
  ports {
    internal = 3000
    external = 3000
  }
  depends_on = [mysql_grant.wikijs, mysql_user.wikijs, mysql_database.wikijs]
}
