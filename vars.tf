# --== General ==-- #
variable "install_root" {
  type = string
}

# --== Database ==-- #
# admin
variable "db_admin_name" {
  type    = string
}
variable "db_admin_password" {
  type    = string
}

# --== Keycloak ==-- #
# keycloak
variable "db_keycloak_name" {
  type    = string
}
variable "db_keycloak_password" {
  type    = string
}
variable "keycloak_user" {
  type    = string
}
variable "keycloak_password" {
  type    = string
}

# --== WikiJS ==-- #
variable "db_wikijs_name" {
  type    = string
}
variable "db_wikijs_password" {
  type    = string
}

