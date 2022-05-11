# --== MySQL ==-- #
variable "mysql_password" {
  type    = string
}

# --== Keycloak ==-- #
variable "db_keycloak_username" {
  type    = string
}
variable "db_keycloak_password" {
  type    = string
}
variable "keycloak_username" {
  type    = string
}
variable "keycloak_password" {
  type    = string
}

# --== WikiJS ==-- #
variable "db_wikijs_username" {
  type    = string
}
variable "db_wikijs_password" {
  type    = string
}

# --== Nextcloud ==-- #
variable "db_nextcloud_username" {
  type    = string
}
variable "db_nextcloud_password" {
  type    = string
}
variable "nextcloud_username" {
  type    = string
}
variable "nextcloud_password" {
  type    = string
}

