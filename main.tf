terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.16.0"
    }
	postgresql = {
	  source  = "cyrilgdn/postgresql"
	  version = ">= 1.15.0"
	}
  }
}

provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

resource "docker_network" "home_network" {
  name   = "home_network"
  driver = "bridge"
}

