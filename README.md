# Terraform
Sets up the home services

## Services
* keycloak (SSO)
* wikijs (wiki)
* nginx (reverse proxy)

## Server Prerequisites
These instructions assume you have the following installed

* [Ubuntu Server](https://ubuntu.com) (22.04 LTS / x86_64)
* [Docker](https://www.docker.com) (v20.10.15)
* [Terraform](https://www.terraform.io) (v1.1.9)
* [Certbot](https://certbot.eff.org) (v1.27.0)

## Pre-Setup
### Docker Setup
The user executing the terraform needs to have the `docker` group

```
sudo gpasswd -a $USER docker
newgrp docker
```
### Certbot
The nginx's is expecting ssl certificates to exist before setup. Register the certs with certbot prior to running terraform
```
sudo certbot certonly --standalone --agree-tos -m ${emil} -d ${domain}
```

## Setup
### Run Terraform
```
terraform init
terraform apply
```
### Setup Keycloak
### Setup

## Post-Setup
### Certbot
After setting up, nginx should be running. We'll want to use this server for future ssl certificate renewals.
Force run the renewal process with the updated parameters.  
```
sudo certbot renew --webroot --cert-name ${domain} --webroot-path ${install_root}/nginx/html --force-renewal
```