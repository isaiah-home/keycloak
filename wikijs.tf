resource "postgresql_role" "wikijs_role" {
  provider   = postgresql.home_db
  name       = "${var.db_wikijs_name}"
  password   = "${var.db_wikijs_password}"
  login      = true
  depends_on = [time_sleep.db]
}

resource "postgresql_database" "wikijs_db" {
  provider   = postgresql.home_db
  name       = "wikijs"
  owner      = postgresql_role.keycloak_role.name
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
    "DB_TYPE=postgres",
	"DB_HOST=db",
	"DB_PORT=5432",
	"DB_USER=${var.db_wikijs_name}",
	"DB_PASS=${var.db_wikijs_password}",
	"DB_NAME=wikijs"
  ]
  networks_advanced {
    name    = docker_network.home_network.name
	aliases = ["keycloak"]
  }
  ports {
    internal = 3000
    external = 3000
  }
  depends_on = [postgresql_database.wikijs_db]
}
