provider "postgresql" {
  alias    = "home_db"
  host     = "localhost"
  port     = 5432
  username = var.db_admin_name
  password = var.db_admin_password
  sslmode  = "disable"
}

resource "docker_image" "postgres" {
  name         = "postgres:14"
  keep_locally = true
}

resource "docker_container" "db" {
  image         = docker_image.postgres.latest
  name          = "db"
  hostname      = "db"
  env   = [
    "POSTGRES_USER=${var.db_admin_name}",
	"POSTGRES_PASSWORD=${var.db_admin_password}"
  ]
  networks_advanced {
    name    = docker_network.home_network.name
	aliases = ["db"]
  }
  ports {
    internal = 5432
    external = 5432
  }
}

resource "time_sleep" "db" {
  create_duration = "30s"
  depends_on = [docker_container.db]
}
