resource "docker_image" "nginx" {
  name         = "nginx:1.21"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image         = docker_image.nginx.latest
  name          = "nginx"
  hostname      = "nginx"
  networks_advanced {
    name    = docker_network.home_network.name
    aliases = ["nginx"]
  }
  ports {
    internal = 80
    external = 80
  }
  volumes {
    container_path = "/etc/nginx/nginx.conf"
    host_path      = "${abspath(path.module)}/Nginx/nginx.conf"
    read_only      = true
  }
  depends_on = [
    local_file.nginx_conf,
    docker_container.keycloak,
    docker_container.wikijs
  ]
}

resource "local_file" "nginx_conf" {
  filename = "${path.module}/Nginx/nginx.conf"
  content = <<EOT
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
    worker_connections 768;
    # multi_accept on;
}

http {

    ##
    # Basic Settings
    ##

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    gzip on;

    include /etc/nginx/conf.d/*.conf;

    server {
        listen 80;
        server_name keycloak.${var.domain};

        location / {
            proxy_set_header        Host $host;
            proxy_set_header        X-Real-IP $remote_addr;
            proxy_set_header        Referer $http_referer;
            proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header        X-Forwarded-Proto $scheme;

            proxy_pass              http://keycloak:8080;
        }
    }

    server {
        listen 80;
        server_name wikijs.${var.domain};

        location / {
            proxy_set_header        Host $host;
            proxy_set_header        X-Real-IP $remote_addr;
            proxy_set_header        Referer $http_referer;
            proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header        X-Forwarded-Proto $scheme;

            proxy_pass              http://wikijs:3000;
        }
    }
}
EOT
}
