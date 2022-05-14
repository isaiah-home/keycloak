resource "mysql_database" "nextcloud" {
  default_character_set = "utf8mb3"
  name                  = "nextcloud"
  depends_on = [docker_container.mysql]
}

resource "mysql_user" "nextcloud" {
  user               = "${var.db_nextcloud_username}"
  host               = "172.22.0.5"
  plaintext_password = "${var.db_nextcloud_password}"
  depends_on = [docker_container.mysql]
}

resource "mysql_grant" "nextcloud" {
  user = "${mysql_user.nextcloud.user}"
  host = "${mysql_user.nextcloud.host}"
  database = "${mysql_database.nextcloud.name}"
  privileges = ["ALL PRIVILEGES"]
  depends_on = [mysql_user.nextcloud, mysql_database.nextcloud]
}

resource "docker_image" "nextcloud" {
  name         = "nextcloud:23-apache"
  keep_locally = true
}

resource "docker_container" "nextcloud" {
  image         = docker_image.nextcloud.latest
  name          = "nextcloud"
  hostname      = "nextcloud"
  env   = [
    "MYSQL_HOST=mysql",
    "DB_PORT=3306",
    "MYSQL_USER=${var.db_nextcloud_username}",
    "MYSQL_PASSWORD=${var.db_nextcloud_password}",
    "MYSQL_DATABASE=nextcloud",
    "OVERWRITEPROTOCOL=https",
    "NEXTCLOUD_ADMIN_USER=${var.nextcloud_username}",
    "NEXTCLOUD_ADMIN_PASSWORD=${var.nextcloud_password}",
    "NEXTCLOUD_TRUSTED_DOMAINS=nextcloud.ivcode.org"
  ]
  networks_advanced {
    name    = docker_network.home_network.name
    aliases = ["nextcloud"]
    ipv4_address = "172.22.0.5"
  }
  ports {
    internal = 80
    external = 8000
  }
  volumes {
    container_path = "/config/config.php"
    host_path      = "${var.install_root}/nextcloud"
  }
  depends_on = [mysql_grant.nextcloud, mysql_user.nextcloud, mysql_database.nextcloud]
}
