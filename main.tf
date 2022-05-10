terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.16.0"
    }
    mysql = {
      source  = "bangau1/mysql"
      version = ">= 1.10.4"
    }
  }
}

provider "docker" {
}

resource "docker_network" "home_network" {
  name   = "home_network"
  driver = "bridge"

  ipam_config {
    aux_address = {}
    gateway     = "172.22.0.1"
    subnet      = "172.22.0.0/16"
  }
}
