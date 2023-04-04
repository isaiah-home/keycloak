resource "docker_image" "pihole" {
  name = "pihole/pihole:2023.03.1"
  keep_locally = true
}

resource "docker_container" "pihole" {
  image   = docker_image.pihole.image_id
  name    = "organize-me-pihole"
  restart = "unless-stopped"
  env = [
    "TZ=${var.timezone}",
    "WEBPASSWORD=${data.aws_ssm_parameter.pihole_webpassword.value}"
  ]
  volumes {
    container_path = "/etc/pihole"
    host_path      = "${var.install_root}/pihole/etc/pihole"
  }
  volumes {
    container_path = "/etc/dnsmasq.d"
    host_path      = "${var.install_root}/pihole/etc/dnsmasq.d"
  }
  ports {
    internal = 53
    external = 53
    protocol = "tcp"
  }
  ports {
    internal = 53
    external = 53
    protocol = "udp"
  }
  ports {
    internal = 67
    external = 67
    protocol = "udp"
  }
  ports {
    internal = 80
    external = 8888
    protocol = "tcp"
  }
  capabilities {
    add = ["NET_ADMIN"]
  }
}
