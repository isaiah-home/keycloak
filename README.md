# terraform-local
Sets up the home services on the local machine

## Services
* keycloak (SSO)
* wikijs (wiki)
* nextcloud (files, notes, calendar, etc..)
* snipe-it (inventory)

## Notes
 * terraform-local uses variables defined in the ```env.sh``` script setup in the ```init``` repo.

## Run Terraform
```
terraform init
terraform apply
```
