resource "mysql_database" "keycloak" {
  default_character_set = "utf8mb3"
  name = "keycloak"
  depends_on = [docker_container.mysql]
}

resource "mysql_user" "keycloak" {
  user               = "${var.db_keycloak_username}"
  host               = "172.22.0.3"
  plaintext_password = "${var.db_keycloak_password}"
  depends_on = [docker_container.mysql]
}

resource "mysql_grant" "keycloak" {
  user = "${mysql_user.keycloak.user}"
  host = "${mysql_user.keycloak.host}"
  database = "${mysql_database.keycloak.name}"
  privileges = ["ALL PRIVILEGES"]
  depends_on = [mysql_user.keycloak, mysql_database.keycloak]
}

resource "docker_image" "keycloak" {
  name         = "jboss/keycloak:16.1.1"
  keep_locally = true
}

resource "docker_container" "keycloak" {
  image         = docker_image.keycloak.latest
  name          = "keycloak"
  hostname      = "keycloak"
  env   = [
    "KEYCLOAK_USER=${var.keycloak_username}",
    "KEYCLOAK_PASSWORD=${var.keycloak_password}",
    "DB_VENDOR=mysql",
    "DB_ADDR=mysql",
    "DB_PORT=3306",
    "DB_DATABASE=keycloak",
    "DB_USER=${var.db_keycloak_username}",
    "DB_PASSWORD=${var.db_keycloak_password}",
    "PROXY_ADDRESS_FORWARDING=true",
    "JDBC_PARAMS=connectTimeout=30"
  ]
  networks_advanced {
    name    = docker_network.home_network.name
    aliases = ["keycloak"]
    ipv4_address = "172.22.0.3"
  }
  ports {
    internal = 8080
    external = 8080
  }
  depends_on = [mysql_grant.keycloak, mysql_user.keycloak, mysql_database.keycloak]
}
