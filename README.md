# terraform-local
Sets up the home services on the local machine

## Services
* Keycloak (SSO)
* MySQL (database)
* WikiJs (wiki)
* Nextcloud (files, notes, calendar, etc..)
* Snipe-IT (inventory)
* Vaultwarden (password manager)
* Pi-hole (network ad-blocker / local dns)

## Notes
 * Uses variables defined in the ```env.sh``` script setup in the ```init``` repo.
 * Uses aws paramiters defined in the ```init``` repo

## Useful Commands
 * If the envoirnment needs destroyed and rebuilt, you'll need to delete the network manuaaly
'docker network rm organize_me_network'

## Run Terraform
```
terraform init
terraform apply
```
