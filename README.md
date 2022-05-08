# Terraform
Sets up the home services

## Services
 * keycloak (SSO)
 * wikijs (wiki)
 * nginx (reverse proxy)

## Server Prerequisites
These instructions assume you have the following installed 

 * [Ubuntu Server](https://ubuntu.com/download/server) (22.04 LTS / x86_64)
 * [Docker](https://docs.docker.com/engine/install/ubuntu/) (v20.10.15)
 * [Terraform](https://www.terraform.io/cli/install/apt) (v1.1.9)

## Setup

### Docker Setup
The user executing the terraform needs to have the `docker` group

```
sudo gpasswd -a $USER docker
newgrp docker
```

### Run Terraform
```
terraform init
terraform apply
```
### Setup Keycloak
### Setup
