resource "postgresql_role" "keycloak_role" {
  provider   = postgresql.home_db
  name       = "${var.db_keycloak_name}"
  password   = "${var.db_keycloak_password}"
  login      = true
  depends_on = [time_sleep.db]
}

resource "postgresql_database" "keycloak_db" {
  provider   = postgresql.home_db
  name       = "keycloak"
  owner      = postgresql_role.keycloak_role.name
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
    "KEYCLOAK_USER=${var.keycloak_user}",
	"KEYCLOAK_PASSWORD=${var.keycloak_password}",
	"DB_VENDOR=postgres",
	"DB_ADDR=db",
	"DB_PORT=5432",
	"DB_DATABASE=keycloak",
	"DB_USER=${var.db_keycloak_name}",
	"DB_PASSWORD=${var.db_keycloak_password}",
	"JDBC_PARAMS=connectTimeout=30"
  ]
  networks_advanced {
    name    = docker_network.home_network.name
	aliases = ["keycloak"]
  }
  ports {
    internal = 8080
    external = 8080
  }
  depends_on = [postgresql_database.keycloak_db]
}