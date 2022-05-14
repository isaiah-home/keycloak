resource "mysql_database" "snipeit" {
  default_character_set = "utf8mb3"
  name = "snipeit"
  depends_on = [docker_container.mysql]
}

resource "mysql_user" "snipeit" {
  user               = "${var.snipeit_db_username}"
  host               = "172.22.0.6"
  plaintext_password = "${var.snipeit_db_password}"
  depends_on = [docker_container.mysql]
}

resource "mysql_grant" "snipeit" {
  user = "${mysql_user.snipeit.user}"
  host = "${mysql_user.snipeit.host}"
  database = "${mysql_database.snipeit.name}"
  privileges = ["ALL PRIVILEGES"]
  depends_on = [mysql_user.snipeit, mysql_database.snipeit]
}

resource "docker_image" "snipeit" {
  name         = "snipe/snipe-it:v5.4.4"
  keep_locally = true
}

resource "docker_container" "snipeit" {
  image         = docker_image.snipeit.latest
  name          = "snipeit"
  hostname      = "snipeit"
  env   = [
    "MYSQL_PORT_3306_TCP_ADDR=mysql",
    "MYSQL_PORT_3306_TCP_PORT=3306",
    "MYSQL_DATABASE=${mysql_database.snipeit.name}",
    "MYSQL_USER=${var.snipeit_db_username}",
    "MYSQL_PASSWORD=${var.snipeit_db_password}",
    "MAIL_PORT_587_TCP_ADDR=${var.smtp_host}",
    "MAIL_PORT_587_TCP_PORT=${var.smtp_port}",
    "MAIL_ENV_FROM_ADDR=${var.snipeit_email_from_addr}",
    "MAIL_ENV_FROM_NAME=${var.snipeit_email_from_name}",
    "MAIL_ENV_ENCRYPTION=tls",
    "MAIL_ENV_USERNAME=${var.smtp_username}",
    "MAIL_ENV_PASSWORD=${var.smtp_password}",
    "APP_ENV=production",
    "APP_DEBUG=false",
    "APP_KEY=${var.snipeit_appkey}",
    "APP_URL=${var.snipeit_url}",
    "APP_TRUSTED_PROXIES=172.22.0.0/16",
    "APP_TIMEZONE=${var.snipeit_timezone}",
    "APP_LOCALE=${var.snipeit_locale}"
  ]
  networks_advanced {
    name    = docker_network.home_network.name
    aliases = ["snipeit"]
    ipv4_address = "172.22.0.6"
  }
  ports {
    internal = 80
    external = 6002
  }
  depends_on = [mysql_grant.snipeit, mysql_user.snipeit, mysql_database.snipeit]
}
